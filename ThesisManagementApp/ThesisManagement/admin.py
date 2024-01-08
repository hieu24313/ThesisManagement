from django.contrib import admin
from django.template.response import TemplateResponse
from .models import User, Criteria, Position, Majors
from ThesisManagement import dao
from django.utils.html import mark_safe
from django import forms
from django.urls import path
import datetime
# Register your models here.


class CourseAppAdminSite(admin.AdminSite):
    site_header = 'Thesis Management'

    def get_urls(self):
        return [
                   path('stats/', self.stats_view)
               ] + super().get_urls()

    def stats_view(self, request):
        today = datetime.date.today()
        current_year = today.year

        return TemplateResponse(request, 'admin/stats.html', {
            'stats': dao.get_year_do_thesis()
        })


admin_site = CourseAppAdminSite(name='Thesis Management')


class UserAdmin(admin.ModelAdmin):
    list_display = ['username', 'first_name', 'last_name', 'email', 'date_joined', 'is_staff']


class CriteriaAdmin(admin.ModelAdmin):
    list_display = ['id', 'name', 'active']


admin_site.register(User, UserAdmin)
admin_site.register(Criteria, CriteriaAdmin)
admin_site.register(Position)
admin_site.register(Majors)

