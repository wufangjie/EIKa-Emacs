//! A smart (daemon/client) emacs launcher on macos
//!
//! version 0.1.0
//! cargo build --release
//! sudo mv ./target/release/emacs /usr/local/bin/ # or any directory in $PATH
//!
//! NOTE: Do not change the name `emacs`, two features will rely on it:
//! 1. `emacs --daemon` will be called when running emacs without daemon existed
//! 2. `open -a emacs` will be called to activate the new opened emacs

use std::env;
use std::process::Command;

const EMACS: &str = "/Applications/Emacs.app/Contents/MacOS/Emacs";
const EMACS_CLIENT: &str = "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient";

fn emacs_start_daemon() {
    Command::new(EMACS)
        .arg("--daemon")
        .output()
        .expect("Failed: running emacs --daemon");
}

fn emacs_kill_daemon() {
    Command::new(EMACS_CLIENT)
        .arg("--eval")
        .arg("(kill-emacs)") // no quote is needed
        .output()
        .expect("Failed: killing emacs daemon");
}

fn emacs_start_client() {
    Command::new(EMACS_CLIENT)
        //.arg("--no-wait")
        .arg("-c")
        .arg("-a")
        .arg("") // NOTE: if no daemon existed, run `emacs --daemon` and retry
        .spawn() // NOTE: use spawn instead of `&>/dev/null &`
        .expect("Failed: running emacsclient");
}

fn activate_emacs() {
    Command::new("open")
        .arg("-a")
        .arg("emacs")
        .output()
        .expect("Failed: activating emacs");
}

fn main() {
    let mut args = env::args();
    let cmd = args.next().unwrap();

    match args.next() {
        None => {
            emacs_start_client();
            activate_emacs();
        }
        Some(s) => match &s[..] {
            "-d" | "--daemon" => emacs_start_daemon(),
            "-k" | "--kill" => emacs_kill_daemon(),
            "-r" | "--restart" => {
                emacs_kill_daemon();
                emacs_start_daemon();
            }
            "-H" | "--help" => {
                println!("Usage: emacs [OPTION]");
                println!("Open emacs in a smart way.");
                println!();
                println!("The following OPTIONS are accepted:");
                println!("-d, --daemon     Start an emacs daemon process");
                println!("-k, --kill       Kill the emacs daemon process");
                println!("-r, --restart    Restart the emacs daemon process");
                println!("-H, --help       Print this usage information message");
                println!("-V, --version    Just print version info and return");
                println!();
            }
            "-V" | "--version" => println!(env!("CARGO_PKG_VERSION")),
            other => {
                println!("{}: unrecognized option '{}'", cmd, other);
                println!("Try '{} --help' for more information", cmd);
            }
        },
    }
}
