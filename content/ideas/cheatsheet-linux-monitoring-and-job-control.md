# vim: syntax=markdown

# Linux System Monitoring
* [4 open source tools for Linux system monitoring](https://opensource.com/life/16/2/open-source-tools-system-monitoring?sc_cid=70160000000lcFhAAI)

Linux is a multitasking operating systems, that is,
a system that can run multiple commands (process) during the same period of time.
Job control is nothing but the ability to stop/suspend the execution of processes
and continue/resume their execution as per your requirements.
This is done using your operating system and
[shell][05] such as [bash][03]/[ksh][04] or any [POSIX shell][02].
Your shell keeps a table of current jobs, called job table.
When you type command the shell assigns a jobID.
A jobID is nothing but small integer numbers.

Turning job control on via monitor mode:
You turn on job control via `set +m` (this is the default) and off via  `set -m`.
So with `set +m`, job control is enabled, all processes run in a separate process group,
and when a background job completes, the shell prints a line containing its exit status.

There are also shortcuts %+ for the most recently foregrounded job and %- for the previously foregrounded job, so you can switch back and forth rapidly between two jobs with CtrlZ followed by fg %- (suspend the current one, resume the other one) without having to remember the numbers. Or you can use the beginning of the command itself. If you have suspended an ffmpeg command, resuming it is as easy as fg %ff (assuming no other active jobs start with "ff"). And as one last shortcut, you don't have to type the fg. Just entering %- as a command foregrounds the previous job.


Foreground
:   Normal commands are run as foreground jobs.
    The shell waits (won't run anymore commands) until the foreground job finishes.
    ^C quits a foreground job. ^Z suspends a foreground job.
    There can (obviously) be only one foreground job at a time.

Background
:   A background job (or a job run in the background) runs as normal,
    but the shell does not wait.
    It can take other commands while the background job is running.
    Most commands run so quickly you won't even notice foreground/background,
    so I'll use the sleep command.
    sleep 3 says to wait for 3 seconds. A semi-colon separates two commands.

Session
:   A session is a set of processes which shares a controlling terminal.

Daemon
:   A daemon is a type of program on Unix-like operating systems
    that runs unobtrusively in the background,
    rather than under the direct control of a user,
    waiting to be activated by the occurrence of a specific event or condition.

# Sessions and Process Groups
http://www.informit.com/articles/article.aspx?p=397655&seqNum=6

# Job Control Commands
* [Job Control Commands](http://tldp.org/LDP/abs/html/x9644.html)

* ps - list the processes running on the system
* jobs - list current jobs
* disown %<jobid> - separate a <jobid> from jobs table
* bg %<jobid> - run the suspended command in background
* fg %<jobid> - resume a background process to foreground
* who -
* wait -
* stop - Suspend the job (same as <Ctrl>-Z)
* sleep -
* kill - Terminate the job (same as <Ctrl>-C)
* setsid <command> - run a program in a new session
* setsid - Set Session ID creates a new session ID for the command you run using it, so it does not deppend on your shell session, therefore if that shell session is closed the other command will stay running.
* nohup <command> - run a command immune to SIGHUP signal , and redirect stdout to a normal file
* <command> & -

* <Ctrl>-Z - suspend the current program associated with your terminal. (sending SIGTSTP to it)
* <Ctrl>-C - stop the current program associated with your terminal. (sending SIGINT to it)

`setsid` is useful when you want to start a new session, because you have started to be connected to a new terminal -- such as when starting a shell inside a terminal emulator -- or you want a daemon (which you don't want to be associated with a controlling terminal).

# Nohup vs. Screen vs. Setid
One thing must be clarified, using screen and nohup, you can return and check the output of the running commands, with screen because you can attach a screen session, and with nohup, because you can check the output file.

Using setsid that is not possible, so only use it, when the output is not important for you.
setsid creates a new session id for the command you run using it, so it does not deppend on your shell session, therefore if that shell session is closed the other command will stay running.

http://go2linux.garron.me/linux/2010/12/setsid-how-execute-commands-after-you-exit-shell-prompt-866/

# ps
xxx

```bash
$ xeyes
^Z
[1]+  Stopped                 xeyes

$ ps T
  PID TTY      STAT   TIME COMMAND
 2751 pts/24   T      0:00 xeyes
 2766 pts/24   R+     0:00 ps T
15044 pts/24   Ss     0:00 bash

$ bg 1
[1]+ xeyes &

$ ps T
  PID TTY      STAT   TIME COMMAND
 2751 pts/24   S      0:00 xeyes
 2777 pts/24   R+     0:00 ps T
15044 pts/24   Ss     0:00 bash
$
```

If you execute `ps aux` or `ps T` you see column called `STAT`, listing the process state code,
which has the following meaning:

```
PROCESS STATE CODES
       Here are the different values that the s, stat and state output specifiers (header "STAT" or "S") will display to describe the state of a process:
       D    uninterruptible sleep (usually IO)
       R    running or runnable (on run queue)
       S    interruptible sleep (waiting for an event to complete)
       T    stopped, either by a job control signal or because it is being traced.
       W    paging (not valid since the 2.6.xx kernel)
       X    dead (should never be seen)
       Z    defunct ("zombie") process, terminated but not reaped by its parent.

       For BSD formats and when the stat keyword is used, additional characters may be displayed:
       <    high-priority (not nice to other users)
       N    low-priority (nice to other users)
       L    has pages locked into memory (for real-time and custom IO)
       s    is a session leader
       l    is multi-threaded (using CLONE_THREAD, like NPTL pthreads do)
       +    is in the foreground process group.
```

# Kill
While the kill command is used to "kill" processes,
its real purpose is to send signals to processes.
Most of the time the signal is intended to tell the process to go away,
but there is more to it than that.
Programs (if they are properly written) listen for signals from the operating system and respond to them,
most often to allow some graceful method of terminating.
(For example, a text editor might listen for any signal that indicates that the user is
logging off or that the computer is shutting down.
When it receives this signal, it saves the work in progress before it exits.)

The kill command can send a variety of signals to processes.
Typing `kill -l` will give you a list of the signals it supports:

```bash
$ kill -l
 1) SIGHUP	      2) SIGINT        3) SIGQUIT	     4) SIGILL	     5) SIGTRAP
 6) SIGABRT	      7) SIGBUS  	   8) SIGFPE	     9) SIGKILL     10) SIGUSR1
11) SIGSEGV	     12) SIGUSR2      13) SIGPIPE     14) SIGALRM     15) SIGTERM
16) SIGSTKFLT	 17) SIGCHLD      18) SIGCONT     19) SIGSTOP     20) SIGTSTP
21) SIGTTIN      22) SIGTTOU      23) SIGURG      24) SIGXCPU     25) SIGXFSZ
26) SIGVTALRM    27) SIGPROF      28) SIGWINCH	29) SIGIO       30) SIGPWR
31) SIGSYS       34) SIGRTMIN     35) SIGRTMIN+1	36) SIGRTMIN+2	37) SIGRTMIN+3
38) SIGRTMIN+4   39) SIGRTMIN+5   40) SIGRTMIN+6	41) SIGRTMIN+7	42) SIGRTMIN+8
43) SIGRTMIN+9   44) SIGRTMIN+10  45) SIGRTMIN+11	46) SIGRTMIN+12	47) SIGRTMIN+13
48) SIGRTMIN+14  49) SIGRTMIN+15  50) SIGRTMAX-14	51) SIGRTMAX-13	52) SIGRTMAX-12
53) SIGRTMAX-11  54) SIGRTMAX-10  55) SIGRTMAX-9	56) SIGRTMAX-8	57) SIGRTMAX-7
58) SIGRTMAX-6   59) SIGRTMAX-5   60) SIGRTMAX-4	61) SIGRTMAX-3	62) SIGRTMAX-2
63) SIGRTMAX-1   64) SIGRTMAX
```

Most are rather obscure, but a few should be committed to memory:

| Signal No. | Signal Name | Description |
|:----------:|:-----------:|:------------|
|     1      |   SIGHUP    | Hang up signal. Programs can listen for this signal and act (or not act) upon it. |
|    15      |   SIGTERM   | Termination signal. This signal is given to processes to terminate them. Again, programs can process this signal and act upon it. You can also issue this signal directly by typing control-c in the terminal window where the program is running. This is the default signal sent by the kill command if no signal is specified. |
|     9      |   SIGKILL   | Kill signal. This signal causes the immediate termination of the process by the Linux kernel. Programs cannot listen for this signal. |

# Cause a process to become a daemon
* [Cause a process to become a daemon](http://www.microhowto.info/howto/cause_a_process_to_become_a_daemon.html)
* [daemonizing bashhttp://blog.n01se.net/blog-n01se-net-p-145.html)

# Screen
* [Speaking UNIX: Stayin' alive with Screen](http://www.ibm.com/developerworks/aix/library/au-gnu_screen/)
* [screen Quick Reference Sheet](http://aperiodic.net/screen/quick_reference)
* [screen Setup and Use](http://aperiodic.net/screen/)
* [Linux and Unix screen command](http://www.computerhope.com/unix/screen.htm)
* [How To Use Linux Screen](https://www.rackaid.com/blog/linux-screen-tutorial-and-how-to/)
* [10 Screen Command Examples to Manage Linux Terminals](http://www.tecmint.com/screen-command-examples-to-manage-linux-terminals/)
* [How do I kill all screens?](http://unix.stackexchange.com/questions/94527/how-do-i-kill-all-screens)
* [kill a screen (but not all screens)](http://serverfault.com/questions/96406/kill-a-screen-but-not-all-screens)
* [Move a running process to a new screen shell](http://monkeypatch.me/blog/move-a-running-process-to-a-new-screen-shell.html)
* []()


* [How can I close a terminal without killing the command running in it?](http://unix.stackexchange.com/questions/4004/how-can-i-close-a-terminal-without-killing-the-command-running-in-it)
* [Difference between nohup, disown and &](http://unix.stackexchange.com/questions/3886/difference-between-nohup-disown-and)
* [Disown a Running Shell Process and Reattach It to a New Screen](https://www.shell-tips.com/2014/09/09/disown-a-running-shell-process-and-reattach-it-to-a-new-screen/)
* [LINUX - Jobs - Move Running Process to Background & Nohup](http://www.kossboss.com/linux---move-running-to-process-nohup)
* [11 fg, bg, disown and jobs commands you should know](http://www.linuxnix.com/11-fc-bg-jobs-commands-know/)
* [10 Linux/Unix Bash and KSH Shell Job Control Examples](http://www.cyberciti.biz/howto/unix-linux-job-control-command-examples-for-bash-ksh-shell/)
* []()


# Nohup and Disown
* [Detaching a process from terminal - exec(), system(), setsid() and nohup](http://mihids.blogspot.com/2015/02/detaching-process-from-terminal-exec.html)
* [Detach Processes With Disown and Nohup](http://www.serverwatch.com/tutorials/article.php/3935306/Detach-Processes-With-Disown-and-Nohup.htm)
* [HOW TO DETACH PROCESS FROM THE TERMINAL IN LINUX](http://www.lostsaloon.com/technology/how-to-detach-process-from-the-terminal-in-linux/)
* [disown, zombie children, and the uninterruptible sleep](https://blogs.oracle.com/ksplice/entry/disown_zombie_children_and_the)
* [Linux:The Ultimate Job Control Commands (job, disown, bg, fg)](http://www.geekpills.com/operating-system/linux/the-ultimate-job-control-commands-job-disown-bg-fg)
* [Running bash commands in the background properly](https://felixmilea.com/2014/12/running-bash-commands-background-properly/)

Job control is nothing but the ability to stop/suspend the execution of processes
(command) and continue/resume their execution as per your requirements.

`[nohup][]`
`[disown][]`

What if you forget to use [`nohup`][01],
or if you didn't expect to be leaving the computer but get called away?
Then there's [`disown`][].

The use of `disown` is a bit more complex than `nohup`.
While your command is running, use `Ctrl-z` to stop it
and then use `bg` to put it in the background.
Then you'll use `disown %n` where `n` is the job number (jobspec).
You can find the job number using the jobs command.
Run jobs again to verify that the job has been detached
and you can use ps or top to verify that the job is actually still running.



[01]:http://linux.die.net/man/1/nohup
[02]:http://www.cyberciti.biz/faq/what-is-posix-shell/
[03]:https://www.gnu.org/software/bash/manual/bash.pdf
[04]:http://www.bolthole.com/solaris/ksh.html
[05]:http://www.freeos.com/guides/lsst/ch01sec07.html
[06]:
[07]:
[08]:
[09]:
[10]:
