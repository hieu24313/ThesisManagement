from rest_framework.response import Response

from .models import ThesisDefenseCommittee
from rest_framework.pagination import PageNumberPagination


class BasePagination(PageNumberPagination):

    def paginate_queryset(self, queryset, request, view=None):
        """
        Override paginate_queryset to return the entire queryset if 'page' parameter is 'all'.
        """
        if request.query_params.get('page') == 'all':
            return None  # Return None to indicate that pagination should not be applied

        return super().paginate_queryset(queryset, request, view)

    def get_paginated_response(self, data):
        """
        Override get_paginated_response to return entire queryset if 'page' parameter is 'all'.
        """
        if self.request.query_params.get('page') == 'all':
            return Response(data)

        return super().get_paginated_response(data)


class ThesisDefenseCommitteePagination(BasePagination):
    page_size = 7


class ThesisPagination(BasePagination):
    page_size = 6


class UserPagination(BasePagination):
    page_size = 6

