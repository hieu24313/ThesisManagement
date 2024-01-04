from django.utils.deprecation import MiddlewareMixin


class OAuthMiddleware(MiddlewareMixin):

    def process_request(self, request):
        # Kiểm tra nếu đây là URL /o/token/ và request method là POST
        if request.path_info == '/o/token/' and request.method == 'POST':
            # Thêm client_id và client_secret vào request POST data
            request.POST = request.POST.copy()
            request.POST['client_id'] = 'kECtsLYTTj8xy1BbpTQ0CNjAGyeOl7w7SmAc8Vl8'
            request.POST['client_secret'] = 'ALonGeXwPqAkMdOwlKFg4apGfju29abCV0fzJ5nh3Xd0eNVI5hXjKJHe07e4onHEjekC6i0QYD1NMXQP2bpYVZfKTAfAaSe3FfBwJPPQJLWn3fqiuKM6owGm63oVZO8o'
            request.POST['grant_type'] = 'password'


