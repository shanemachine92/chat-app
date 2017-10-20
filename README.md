### A Command Line Based Ruby-based Chat Server

This is a command line based client/server chat that uses ruby-based TCP sockets. 

#### Features

* multiple simultaneously connected sessions
* multiple chat rooms so that messages sent in a room are only visible to other people in that room
* usernames so that you can ID who is in a given room and display their username when they send messages

#### Getting Started

1. To get chatting, first clone the repo: `git clone git@github.com:shanemachine92/chat-app.git`

2. Use `cd` to navigate to the main directory, `chat-app`

3. run the command `ruby script.rb` to start the server in your terminal.

You should get the following output: 

`Chat server started on port: 3333`

Note: The app is currently set to run on port `3333`, but you can specify any port by changing this in the `script.rb` file.


4. From another terminal window, run the command `telnet localhost 3333`. If you have changed the port number in `script.rb`, don't forget to replace `3333` with your specified port in this command!

5. Input your user information and create a chat room or join an existing chat room

6. Connect to the server from other terminal windows  and repeat to see how messages are shared (or not) when users are in the same or different chat rooms!

To disconnect your client from the server, run `control + ]` to enter into the telnet cli. Input `c` and hit `enter` to close the connection.




