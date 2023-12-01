from rest_framework.permissions import BasePermission


class HasRolePermission(BasePermission):
    message = "Bạn không có quyền truy cập tài nguyên này."

    def has_permission(self, request, view):
        required_role = getattr(view, 'required_role', None)
        if required_role and request.user.has_role(required_role):
            return True
        return False



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