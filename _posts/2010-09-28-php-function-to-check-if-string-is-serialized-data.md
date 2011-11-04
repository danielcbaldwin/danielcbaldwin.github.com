---
layout: post
title: A handy function for PHP that checks if a string is actually something that has been serialized
published: true
---
A nice function taken from WordPress that allows you to check if a string is serialized. This is handy because for some weird reason it isn't enough that unserialize() returns false but it also has to throw a notice. Using this function helps you to avoid the whole notices issue.

<script src="https://gist.github.com/1117347.js?file=serialize_check.php"></script>