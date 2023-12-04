from rest_framework.permissions import BasePermission


class IsAdmin(BasePermission):
    message = "Bạn không có quyền truy cập tài nguyên này."

    def has_permission(self, request, view):
        return request.user.is_authenticated and request.user.role == 'admin'

#guild in view
# from rest_framework.views import APIView
# from rest_framework.response import Response
# from your_app.permissions import HasRolePermission
#
# class ExampleView(APIView):
#     permission_classes = [HasRolePermission]
#     required_role = 'admin'  # Đặt vai trò cần thiết cho view này
#
#     def get(self, request):
#         # Logic xử lý view của bạn ở đây
#         return Response({"message": "Bạn có quyền truy cập view này."})