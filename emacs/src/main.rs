//! A smart (daemon/client) emacs launcher on macos
//!
//! version 0.1.4
//! cargo build --release
//! sudo mv ./target/release/emacs /usr/local/bin/ # or any directory in $PATH
//!
//! NOTE: Do not change the name `emacs`, two features will rely on it:
//! 1. `emacs --daemon` will be called when running emacs without daemon existed
//! 2. `open -a emacs` will be called to activate the new opened emacs

use std::env;
use std::path::Path;
use std::process::{Command, Stdio};
use std::thread;
use std::time::Duration;

const EMACS: &str = "/Applications/Emacs.app/Contents/MacOS/Emacs";
const EMACS_CLIENT: &str = "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient";

#[inline]
fn start_emacs_daemon() {
    Command::new(EMACS)
        .arg("--daemon")
        .output()
        .expect("Failed: start_emacs_daemon");
}

#[inline]
fn kill_emacs_daemon() {
    Command::new(EMACS_CLIENT)
        .arg("--eval")
        .arg("(kill-emacs)") // no quote is needed
        .output()
        .expect("Failed: kill_emacs_daemon");
}

#[inline]
fn start_emacs_client() {
    Command::new(EMACS_CLIENT)
        .arg("--no-wait")
        .arg("--create-frame")
        .arg("--alternate-editor")
        .arg("") // NOTE: if no daemon existed, run `emacs --daemon` and retry
        .stdout(Stdio::null())
        .stderr(Stdio::null())
        .spawn()
        .expect("Failed: start_emacs_client");

    while !is_emacs_frame_existing() {
        thread::sleep(Duration::from_millis(100));
    }
}

#[inline]
fn open_path_in_emacs(path: &Path) {
    // NOTE: Make sure frame exists
    Command::new(EMACS_CLIENT)
        .arg("--no-wait")
        .arg(path)
        .stdout(Stdio::null())
        .stderr(Stdio::null())
        .spawn()
        .expect("Failed: open_path_in_emacs");
}

#[inline]
fn is_emacs_daemon_running() -> bool {
    Command::new(EMACS_CLIENT)
        .arg("--eval")
        .arg("()")
        .stdout(Stdio::null())
        .stderr(Stdio::null())
        .status()
        .expect("Failed: is_emacs_daemon_running")
        .success()
}

#[inline]
fn is_emacs_frame_existing() -> bool {
    Command::new(EMACS_CLIENT)
        .arg("--eval")
        .arg("(if (> (length (frame-list)) 1) t)")
        .output()
        .expect("Failed: is_emacs_frame_existing")
        .stdout
        == vec![b't', b'\n']
}

#[inline]
fn activate_emacs() {
    Command::new("open")
        .arg("-a")
        .arg("emacs")
        .output()
        .expect("Failed: activate_emacs");
}

fn main() {
    let mut args = env::args();
    let cmd = args.next().unwrap();

    match args.next() {
        None => {
            if !is_emacs_frame_existing() {
                start_emacs_client();
            }
            activate_emacs();
        }
        Some(s) => match &s[..] {
            "-d" | "--daemon" => start_emacs_daemon(),
            "-k" | "--kill" => kill_emacs_daemon(),
            "-r" | "--restart" => {
                kill_emacs_daemon();
                start_emacs_daemon();
		start_emacs_client();
		activate_emacs();
            }
            "-n" | "--new" => {
                start_emacs_client();
                activate_emacs();
            }
            "-a" | "--automator" => {
                if !is_emacs_daemon_running() {
                    start_emacs_daemon();
                }
                if !is_emacs_frame_existing() {
                    start_emacs_client();
                }
                activate_emacs();
            }
            "-H" | "--help" => {
                println!("Usage: emacs [OPTION | FILE]");
                println!("Launch emacs in a smart way.");
                println!();
                println!("The following OPTIONS are accepted:");
                println!("-d, --daemon     Start emacs daemon if not exists");
                println!("-k, --kill       Kill the daemon");
                println!("-r, --restart    Restart daemon then open a client");
                println!("-n, --new        Open a new emacs client");
                println!("-a, --automator  Launch emacs, only for Automator");
                println!("-H, --help       Print this usage information message");
                println!("-V, --version    Just print version info and return");
                println!();
            }
            "-V" | "--version" => println!(env!("CARGO_PKG_VERSION")),
            other => {
                let path: &Path = other.as_ref();
                if path.is_dir() || path.is_file() {
                    if !is_emacs_frame_existing() {
                        start_emacs_client();
                    }
                    open_path_in_emacs(path);
                    activate_emacs();
                } else {
                    println!("{}: unrecognized option '{}'", cmd, other);
                    println!("Try '{} --help' for more information", cmd);
                }
            }
        },
    }
}
