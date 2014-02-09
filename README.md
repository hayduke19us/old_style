# old_style for Rails

I'm not the most organized person. It would be a big help to me if there was a helper to keep my stylesheets clean. old_style.gem helps you do that!
old_style compares all of your styles with the differen nodes in your views.
If old_style doesn't find a corresponding id or class or parent node in the html file it registers the style as **Bad**.

####Setup is simple
	gem install 'old_style'
	
#### Commands
###### *In the root of your project
	old_style 'some controller name that has views and stylesheets'

If I had a project  with a posts controller. That posts controller had a set of views and one stylesheet. I would type:

	old_style posts

If my project had a users controller with views and stylesheets and I wanted to include those in the comparison I would type:

	old_style posts users

If all went well an old_style/index.html file has been generated in the root of your project.

	open old_style/index.html

![example index](http://i.imgur.com/mGGpY8m.png)

####Updates
I keep a [work blog](http://octopress.dev/blog/2014/01/30/old-style-dot-gem-work-blog/). But be gental this is just a place for me to write quickly as  I code. I'm a horrible speller.

######Version 1.1.5
 * Nicer old_style/index.html view
 *  Links to each compared file
 * Format moved to a module for better performance
 * ParseDir inherits from LoadDir. More organized code!
 * Testing is in the green.

####Future Features

* I'm hoping to add some more useful functions to the rendered index.html.
* Better accuracy


####Contributing to old_style
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

####Copyright

Copyright (c) 2014 hayduke19us. See LICENSE.txt for
further details.

