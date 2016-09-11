admin_user = User.create(email: 'admin+user@example.org', password: 'passw0rd', password_confirmation: 'passw0rd', first_name: 'Super', last_name: 'Admin', role: 'Admin')

blog_user_1 = User.create(email: 'blog+user+1@example.org', password: 'passw0rd', password_confirmation: 'passw0rd', first_name: 'First', last_name: 'Blogger', role: 'Editor')
blog_user_2 = User.create(email: 'blog+user+2@example.org', password: 'passw0rd', password_confirmation: 'passw0rd', first_name: 'Second', last_name: 'Blogger', role: 'Editor')
blog_user_3 = User.create(email: 'blog+user+3@example.org', password: 'passw0rd', password_confirmation: 'passw0rd', first_name: 'Third', last_name: 'Blogger', role: 'Editor')

post = Category.create(name: 'Post')
recipe = Category.create(name: 'Recipe')
review = Category.create(name: 'Review')

sample_text = '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque at ligula leo. Ut facilisis tellus eget semper volutpat. Fusce ac magna pretium augue pharetra tempus ut at dui.
                  Pellentesque vestibulum odio ut metus cursus, id ullamcorper augue volutpat. Nullam facilisis dui ut metus rhoncus, imperdiet faucibus turpis posuere. Sed tempor vestibulum dolor
                  in auctor.</p><p>Aenean bibendum aliquet velit, nec ultrices dui. Nullam sed enim magna. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.
                  Phasellus in enim tellus. Donec quis elit nec sapien eleifend tempus vel et purus. Integer faucibus, lectus et interdum scelerisque, magna est suscipit neque, vitae rutrum neque
                  felis convallis velit. Nunc sed magna justo. Sed quis lorem et ligula congue ultricies eu at ipsum. In vitae libero nec ligula efficitur viverra at nec nisi. Cum sociis natoque
                  penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>'

Blog.create(title: 'First Blog: Post', body: sample_text, status: 'published', category: post, user: blog_user_1, published_at: 70.days.ago)
Blog.create(title: 'First Blog: Recipe', body: sample_text, status: 'published', category: recipe, user: blog_user_1, published_at: 35.days.ago)
Blog.create(title: 'First Blog: Review', body: sample_text, status: 'published', category: review, user: blog_user_1, published_at: 27.days.ago)
Blog.create(title: 'First Blog: Another Post', body: sample_text, status: 'published', category: post, user: blog_user_1, published_at: 20.days.ago)

Blog.create(title: 'Second Blog: Post', body: sample_text, status: 'published' , category: post, user: blog_user_2, published_at: 18.days.ago)
Blog.create(title: 'Second Blog: Recipe', body: sample_text, status: 'published', category: recipe, user: blog_user_2, published_at: 10.days.ago)
Blog.create(title: 'Second Blog: Review', body: sample_text, status: 'draft', category: review, user: blog_user_2, published_at: 7.days.ago)
Blog.create(title: 'Second Blog: Another Recipe', body: sample_text, status: 'published', category: recipe, user: blog_user_2, published_at: 5.days.ago)

Blog.create(title: 'Third Blog: Post', body: sample_text, status: 'published', category: post, user: blog_user_3, published_at: 3.days.ago)
Blog.create(title: 'Third Blog: Recipe', body: sample_text, status: 'draft', category: recipe, user: blog_user_3, published_at: 7.hours.ago)
Blog.create(title: 'Third Blog: Review', body: sample_text, status: 'draft', category: review, user: blog_user_3)
Blog.create(title: 'Third Blog: Another Review', body: sample_text, status: 'published', category: review, user: blog_user_3, published_at: 5.minutes.ago)

puts '[Create blog to test the activity stream]'
blog_activity = Blog.create(title: 'Activity Blog: Post', body: sample_text, status: 'draft', category: post, user: blog_user_1)

puts '[Update blog to test the activity stream]'
Blog.find(blog_activity).update_attributes(title: 'Activity Blog: Post [updated]', status: 'draft')

puts '[Publish blog to test the activity stream]'
Blog.find(blog_activity).update_attributes(title: 'Activity Blog: Post [published]', status: 'published')

puts '[Update blog to test the activity stream]'
Blog.find(blog_activity).update_attributes(title: 'Activity Blog: Post [updated]')

puts '[Unpublish blog to test the activity stream]'
Blog.find(blog_activity).update_attributes(title: 'Activity Blog: Post [unpublished]', status: 'draft')

puts '[Update blog to test the activity stream]'
Blog.find(blog_activity).update_attributes(title: 'Activity Blog: Post [updated]')

puts '[Destroy blog to test the activity stream]'
Blog.destroy(blog_activity)
