from django.utils.deprecation import MiddlewareMixin


class OAuthMiddleware(MiddlewareMixin):

    def process_request(self, request):
        # Kiểm tra nếu đây là URL /o/token/ và request method là POST
        if request.path == '/o/token/' and request.method == 'POST':
            # Thêm client_id và client_secret vào request POST data
            request.POST = request.POST.copy()
            request.POST['client_id'] = 'E6qkqMboLiY269L4dwciPOvoaW6m4drb7KyxvjB6'
            request.POST['client_secret'] = 'qdiNphOVt6FH8ZGdmbKQcC8xnAssQUajaSeffNXl7STtEhN4uMQ8BsV4QccAYxlISCBLCKBhiifavWGaiX8aWL7faBUzpVMQ3FkzZWYyzAb9xgNvYZGfPskIrY3gu73h'
            request.POST['grant_type'] = 'password'