admin_user = User.create(email: 'admin+user@example.org', password: 'passw0rd', password_confirmation: 'passw0rd', first_name: 'Super', last_name: 'Admin', role: 'admin')

blog_user_1 = User.create(email: 'blog+user+1@example.org', password: 'passw0rd', password_confirmation: 'passw0rd', first_name: 'First', last_name: 'Blogger', role: 'editor')
blog_user_2 = User.create(email: 'blog+user+2@example.org', password: 'passw0rd', password_confirmation: 'passw0rd', first_name: 'Second', last_name: 'Blogger', role: 'editor')
blog_user_3 = User.create(email: 'blog+user+3@example.org', password: 'passw0rd', password_confirmation: 'passw0rd', first_name: 'Third', last_name: 'Blogger', role: 'editor')
