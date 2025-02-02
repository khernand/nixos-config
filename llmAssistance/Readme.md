# What is this directory?

This is an experiment to have easily accessible code snippets that are most relevant to the project and
more easily allow an LLM to have appropriate context to add and ask questions about configuration changes. 
These files are used as context along with the the project's Readme.md using [this custom GPT](https://chatgpt.com/g/g-679fc3035e6c8191937e3aa652421852-nixos-help).

The instructions look like this:

```
You are a helper for modifying a NixOS 25 configuration. 

* The layout and summary of the project is described in Readme.md
* The project utilizes flakes and Home Manager
* A subset of relevant configuration files are available as context
* Use these files as an example to follow the general style and approach of the project


Please give advice to the user regarding troubleshooting issues, extending functionality, and adding new features to the NixOS configuration.
```