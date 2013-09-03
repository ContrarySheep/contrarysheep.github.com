---
layout: post
title: 'Promise Pegasus RAID Scripts'
date: 2012-8-29
category: Code
tags:
 - How-I-Did
 - RAID
 - Sysadmin
excerpt: 'The Pegasus R6 is an incredible storage device, but it lacks the reasonable ability to send email alerts. These scripts, in conjuction with launchd, can provide a decent enough monitoring system.'
---

## Background

The Pegasus R6 is an incredible storage device, but it lacks the reasonable ability to send email alerts. Following Angel's blog post here [here](http://defsci.blogspot.com/2012/01/getting-promise-pegasus-to-actually.html "Def Science"), I modified the scripts so they could run from launchd. Firstly, I had to use the PTY public class in order to communicate with the `promiseutil` command. This is because `promiseutil` is an interactive program that assumes that it is a run through TTY. Secondly, I added in system logging in case the email feature fails for some reason.

## launchd

While these scripts work fine from the terminal's cli, running them through launchd can cause you problems because of the spawning subprocesses (`mail` and `promiseutil`). In order to get those to work properly, you must also use the `AbandonProcessGroup` directive. Below is the example:

     <key>AbandonProcessGroup</key>
     <true/>

You may also need to run the plist files from a user's `LaunchAgents` directory instead of the system's, but YMMV.

## Usage

A lot of isolated testing went into these scripts. We ran these scripts from our machines attached to our Pegasus units, making those unit's fail multiple times in order trigger the events. That being said, we make no guarantee that the scripts will work for you in your environment. In fact, they probably won't. You are encouraged to run the tests yourself and modify the scripts as you see fit.

### raid_monitor.rb

    #!/usr/bin/env ruby

    require "pty"
    require "syslog"

    email = {
      :title => "RAID monitor",
      :sender => "sender@example.com",
      :recipient => "recipient@example.com"
    }

    log_message = "RAID monitor script completed"

    results = ""

    # use PTY to simulate a terminal interaction for the promiseutil workaround.
    PTY.spawn("promiseutil -C phydrv") do |output,input,pid|
      output.each do |l|
        next unless l =~ /^\d/
        unless l =~ /OK/
          results << "RAID 1: BAD DRIVE \n #{l} \n"
        end
      end
    end

    # email the report to the user(s)
    if !results.empty?
      system "echo \"#{results}\" | mail -s '#{email[:title]}' '#{email[:recipient]}' -f '#{email[:sender]}'"
    end

    # log the fact that the script was run successfully
    Syslog.open($0, Syslog::LOG_PID | Syslog::LOG_CONS) { |s| s.warning "#{log_message}" }

### raid_report.rb

    #!/usr/bin/env ruby

    require "pty"
    require "syslog"

    email = {
      :title => "RAID report",
      :sender => "sender@example.com",
      :recipient => "recipient@example.com"
    }

    log_message = "RAID report script completed"

    results = ""

    # use PTY to simulate a terminal interaction for the promiseutil workaround.
    PTY.spawn("promiseutil -C stats") do |output,input,pid|
      output.each { |line| results << line }
    end

    # email the report to the user(s)
    system "echo \"#{results}\" | mail -s '#{email[:title]}' '#{email[:recipient]}' -f '#{email[:sender]}'"

    # log the fact that the script was run successfully
    Syslog.open($0, Syslog::LOG_PID | Syslog::LOG_CONS) { |s| s.warning "#{log_message}" }