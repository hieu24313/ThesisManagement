# import requests
# from django.http import JsonResponse
# from io import BytesIO
# import json
#
#
# class OAuthProxyMiddleware:
#     def __init__(self, get_response):
#         self.get_response = get_response
#
#     def __call__(self, request):
#         # Đảm bảo rằng request method là POST
#         if request.method == 'POST':
#             # Lấy dữ liệu từ body hiện tại của yêu cầu
#             current_body = request.body.decode('utf-8')
#             # Chuyển dữ liệu từ body thành dictionary nếu định dạng là JSON
#             try:
#                 current_data = json.loads(current_body)
#             except json.JSONDecodeError:
#                 current_data = {}
#                 # Thêm thông tin từ add_client_key vào body
#             add_client_key = {
#                 'client_id': 'qmYQmR9yJuY5qEKlMfxFcP6oOnFwRQETSi1ePR6z',
#                 'client_secret': 'L56kd93O90np5q7IOPP2vhsNx5ajGlV5MY6T33s4RlW9m4k9MsLKwC3qpkcTO1ba1WNal0W8rBFkboIbCrTogNqaKxyCQhmblRhzYo9ToA7FJIMtc9ftAStweFIXFhxo',
#                 'grant_type': 'password'
#             }
#             current_data.update(add_client_key)
#
#             # Chuyển dictionary mới thành string và gán vào body của yêu cầu
#             new_body = json.dumps(current_data).encode('utf-8')
#             request._body = new_body
#             request._stream = BytesIO(new_body)
#
#         response = self.get_response(request)
#         # import pdb
#         # pdb.set_trace()
#         return response
#
from django.utils.deprecation import MiddlewareMixin


class OAuthMiddleware(MiddlewareMixin):

    def process_request(self, request):
        # Kiểm tra nếu đây là URL /o/token/ và request method là POST
        if request.path == '/o/token/' and request.method == 'POST':
            # Thêm client_id và client_secret vào request POST data
            request.POST = request.POST.copy()
            request.POST['client_id'] = 'oenqe4z4bNTyBMC4wEMkfdEDTxXMQEP0be4ubttU'
            request.POST['client_secret'] = 'b7REoqTw154lxcSbS9aeL8p2lhNJcrYvqeRCaLXUrDxY3tLaOQhBlHDIqfX2KDdAciUPYOe90tNAQgSiTfffjRFkHK5gXGbbhmEky9tWonlyrPDxcdqqm3XkDyyF8nAR'
            request.POST['grant_type'] = 'password'