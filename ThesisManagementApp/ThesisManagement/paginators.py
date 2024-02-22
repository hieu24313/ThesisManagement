from .models import ThesisDefenseCommittee
from rest_framework.pagination import PageNumberPagination


class ThesisDefenseCommitteePagination(PageNumberPagination):
    page_size = 5
