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

    def get_urls(self): # chưa phân quyền nhé........
        return [
                   path('stats-major/', self.stats_view_major),
                   path('stats-score/', self.stats_view_score)
               ] + super().get_urls()

    def stats_view_major(self, request):

        year = request.GET.get('select_option')
        if year:
            pass
        else:
            today = datetime.date.today()
            year = today.year

        print(year)
        if year == 'all':
            count_thesis_current_year = dao.count_thesis_by_major_and_year()  # count khoa luan trong nam duoc chon
            list_thesis = dao.get_thesis_by_year()
            for t in list_thesis:
                # t.status = dao.get_status_by_id(t.status.id)
                t.student = dao.get_student_by_thesis_id(t)
                t.supervisor = dao.get_lecturer_by_thesis_id(t)
        else:
            list_thesis = dao.get_thesis_by_year(year)
            for t in list_thesis:
                # t.status = dao.get_status_by_id(t.status.id)
                t.student = dao.get_student_by_thesis_id(t)
                t.supervisor = dao.get_lecturer_by_thesis_id(t)
            count_thesis_current_year = dao.count_thesis_by_major_and_year(year)  # count khoa luan trong nam duoc chon
        year_has_thesis = dao.get_year_do_thesis() # lấy những năm có khóa luận được thực hiện
        # count_major_and_thesis = dao.count_thesis_by_year_all()
        return TemplateResponse(request, 'admin/stats_major.html', {
            'year': year_has_thesis,
            # 'list_thesis': list_thesis,
            'major_year': count_thesis_current_year,
            'current_year': year,
            'count_thesis_current_year': count_thesis_current_year,
            # 'major': dao.get_all_major()
        })

    def stats_view_score(self, request):
        year = request.GET.get('year')
        major = request.GET.get('major')

        if year:
            pass
        else:
            today = datetime.date.today()
            year = today.year

        # if year == 'all' and major == 'all':
        score = dao.get_score()
        if year != 'all' and major == 'all':
            score = dao.get_score(year=year)
        if year == 'all' and major != 'all':
            score = dao.get_score(year=year)
        if year != 'all' and major != 'all':
            score = dao.get_score(year=year, major=major)

        get_year_has_thesis = dao.get_year_do_thesis()
        # print(score)

        return TemplateResponse(request, 'admin/stats_score.html', {
            'year_has_thesis': get_year_has_thesis,
            'current_year': year,
            'major': dao.get_all_major(),
            'score': score
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

