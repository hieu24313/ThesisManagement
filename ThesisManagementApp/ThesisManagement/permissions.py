from rest_framework.permissions import BasePermission


class IsAdmin(BasePermission):
    message = "Bạn không có quyền truy cập tài nguyên này."

    def has_permission(self, request, view):
        return request.user.is_authenticated and request.user.role == 'admin'


class IsUniversityAdministrator(BasePermission):
    message = "Bạn không có quyền truy cập tài nguyên này."

    def has_permission(self, request, view):
        return request.user.is_authenticated and request.user.role == 'universityadministrator'


class IsLecturer(BasePermission):
    message = "Bạn không có quyền truy cập tài nguyên này."

    def has_permission(self, request, view):
        return request.user.is_authenticated and request.user.role == 'lecturer'


class IsStudent(BasePermission):
    message = "Bạn không có quyền truy cập tài nguyên này."

    def has_permission(self, request, view):
        return request.user.is_authenticated and request.user.role == 'student'
