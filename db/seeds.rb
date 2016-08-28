admin_user = User.create(email: 'admin+user@example.org', password: 'passw0rd', password_confirmation: 'passw0rd', first_name: 'Super', last_name: 'Admin', role: 'admin')

blog_user_1 = User.create(email: 'blog+user+1@example.org', password: 'passw0rd', password_confirmation: 'passw0rd', first_name: 'First', last_name: 'Blogger', role: 'editor')
blog_user_2 = User.create(email: 'blog+user+2@example.org', password: 'passw0rd', password_confirmation: 'passw0rd', first_name: 'Second', last_name: 'Blogger', role: 'editor')
blog_user_3 = User.create(email: 'blog+user+3@example.org', password: 'passw0rd', password_confirmation: 'passw0rd', first_name: 'Third', last_name: 'Blogger', role: 'editor')

post = Category.create(name: 'Post')
recipe = Category.create(name: 'Recipe')
review = Category.create(name: 'Review')

Blog.create(title: 'First Blog: Post', body: '<p>This is first blog post body.</p>', category: post, user: blog_user_1)
Blog.create(title: 'First Blog: Recipe', body: '<p>This is first blog recipe body.</p>', category: recipe, user: blog_user_1)
Blog.create(title: 'First Blog: Review', body: '<p>This is first blog review body.</p>', category: review, user: blog_user_1)

Blog.create(title: 'Second Blog: Post', body: '<p>This is second blog post body.</p>', category: post, user: blog_user_2)
Blog.create(title: 'Second Blog: Recipe', body: '<p>This is second blog recipe body.</p>', category: recipe, user: blog_user_2)
Blog.create(title: 'Second Blog: Review', body: '<p>This is second blog review body.</p>', category: review, user: blog_user_2)

Blog.create(title: 'Third Blog: Post', body: '<p>This is third blog post body.</p>', category: post, user: blog_user_3)
Blog.create(title: 'Third Blog: Recipe', body: '<p>This is third blog recipe body.</p>', category: recipe, user: blog_user_3)
Blog.create(title: 'Third Blog: Review', body: '<p>This is third blog review body.</p>', category: review, user: blog_user_3)
