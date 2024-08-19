# Are you locked out from too many login attempts?
Then this guide is for you!!

SDDM doesnt actually tell you that you are locked out which is dumb, so open a new tty with control+alt+function-key and try log in.
It will tell you if you are locked out once you enter your username.

Lets hope you have another account with root access.
If you do, log in with that account.

Then run this command with root access, `faillock --user myUsername`.
that will output something like this
```
myUsername:
When            Type     Source     Valid
Timestamp 1     TTY      /dev/tty1  V
Timestamp 2     TTY      /dev/tty1  V
Timestamp 3     TTY      /dev/tty1  V
```

All that text means you are locked out.

To unlock, run that same command with the `--reset` flag.
```
# faillock --user myUsername --reset
# faillock --user myUsername
myUsername:
When            Type     Source     Valid
```

---

# If you want to disable in future

edit the file in `/etc/security/faillock.conf` with sudo.

Uncomment `# deny = 3` and change it to your number of choice.
Or if you want to just change the cooldown edit `# unlock_time = 600`.

This guide from [here](https://superuser.com/questions/1597162/how-to-unlock-linux-user-after-too-many-failed-login-attempts)

Thank you Joost and Eduardo Lucio
