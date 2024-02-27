from django.template.loader import render_to_string
from django.utils.deprecation import MiddlewareMixin


class OAuthMiddleware(MiddlewareMixin):

    def process_request(self, request):
        # Kiểm tra nếu đây là URL /o/token/ và request method là POST
        if request.path_info == '/o/token/' and request.method == 'POST':
            # Thêm client_id và client_secret vào request POST data
            request.POST = request.POST.copy()
            request.POST['client_id'] = 'ruse9DiDD2p74fejZ2T5Ffkibhiq7n2Zl99thins'
            request.POST[
                'client_secret'] = 'zhZ85OhclAoEqPt9egfwsrenlUcMUzdOIzOIHVSbfz2Wo1guoauuQWAmgS6Z6AM5suXL4CpL73zH2VirkuCGlczhBGxMMlErBEdkcxN9297B8KnA5gV60TFt7PxWpoST'
            request.POST['grant_type'] = 'password'


class AdminJSMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        response = self.get_response(request)
        if request.path == '/admin/':
            # Chèn đoạn mã JavaScript vào trang index của Django Admin
            admin_js = render_to_string('admin/admin_custom_script.html')
            response.content += admin_js.encode()
        return response
