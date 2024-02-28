from django.contrib import admin
from django.http import HttpResponse
from django.shortcuts import render
from django.template.response import TemplateResponse
from .models import User, Criteria, Position, Majors
from ThesisManagement import dao
from django.utils.html import mark_safe
from django import forms
from django.urls import path
import datetime
import pandas as pd


# Register your models here.


class ThesisAppAdminSite(admin.AdminSite):
    site_header = 'Thesis Management'

    # def each_context(self, request):
    #     context = super().each_context(request)
    #     context['custom_js'] = 'admin/js/admin_custom.js'  # Đường dẫn tới tệp JavaScript của bạn
    #     return context

    def get_urls(self):
        return [
            path('stats-major/', self.stats_view_major),
            path('stats-score/', self.stats_view_score),
            path('add-more-users/', self.add_user_by_excel)
        ] + super().get_urls()

    # def get_media(self):
    #     # Ghi đè phương thức này để thêm các tập tin media
    #     media = super().get_media()
    #     media.add_js(['admin/js/admin_custom.js'])
    #     return media

    def stats_view_major(self, request):
        user = request.user
        # print(user.role)
        if user.is_anonymous or user.role != 'admin':
            return TemplateResponse(request, 'admin/403.html')
        # if user.role != 'admin':
        #     return TemplateResponse(request, 'admin/403.html')
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
        year_has_thesis = dao.get_year_do_thesis()  # lấy những năm có khóa luận được thực hiện
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
        user = request.user
        print(user)
        if user.is_anonymous or user.role != 'admin':
            return TemplateResponse(request, 'admin/403.html')
        # if user.role != 'admin':
        #     return TemplateResponse(request, 'admin/403.html')
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
            score = dao.get_score(major=major)
        if year != 'all' and major != 'all':
            score = dao.get_score(year=year, major=major)

        get_year_has_thesis = dao.get_year_do_thesis()
        print(major)
        if major != 'all' and major is not None:
            major = Majors.objects.get(pk=major)
        return TemplateResponse(request, 'admin/stats_score.html', {
            'year_has_thesis': get_year_has_thesis,
            'current_year': year,
            'major': dao.get_all_major(),
            'current_major': major,
            'score': score
        })

    def add_user_by_excel(self, request):
        user = request.user
        # print(user.role)
        if user.is_anonymous or user.role != 'admin':
            return TemplateResponse(request, 'admin/403.html')
        server_domain = request.META['HTTP_HOST']
        full_url = request.build_absolute_uri()
        # return JsonResponse({'pdf_url': f'{server_domain}/static{file_url}'})
        print(server_domain)
        # print(full_url)
        file_mau = f'http://{server_domain}/static/media/BieuMauFile.xlsx'
        if request.method == 'POST' and request.FILES['excel_file']:
            excel_file = request.FILES['excel_file']
            if excel_file.name.endswith('.xls') or excel_file.name.endswith('.xlsx'):
                df = pd.read_excel(excel_file)
                rows = df.values.tolist()
                print(rows[0])
                last_user = User.objects.last()
                id_last_user = last_user.id + 1
                for r in rows:
                    print(r)
                    username = 'sinhvien' + str(id_last_user)
                    id_last_user += 1
                    u = User.objects.create(username=username, last_name=r[2], first_name=r[1], role="student", email=r[3])
                    u.set_password('123')
                    u.save()
                # for row in df.iterrows():
                #     process(row)

                return HttpResponse("File Excel đã được đọc thành công! Toàn bộ sinh viên đã được thêm!")
            else:
                return HttpResponse("Vui lòng tải lên một file Excel hợp lệ.")
        else:
            return render(request, 'admin/add_more_users.html', {
                'link': file_mau
            })


admin_site = ThesisAppAdminSite(name='Thesis Management')


class CustomModelAdmin(admin.ModelAdmin):
    class Media:
        js = ('admin/js/admin_custom.js',)


class UserAdmin(CustomModelAdmin):
    list_display = ['username', 'first_name', 'last_name', 'email', 'date_joined', 'is_staff']
    class Media:
        js = ('admin/js/user_custom.js',)


class CriteriaAdmin(CustomModelAdmin):
    list_display = ['id', 'name', 'active']


admin_site.register(User, UserAdmin)
admin_site.register(Criteria, CriteriaAdmin)
admin_site.register(Position, CustomModelAdmin)
admin_site.register(Majors, CustomModelAdmin)
