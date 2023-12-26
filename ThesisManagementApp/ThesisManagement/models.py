from django.db import models
from django.contrib.auth.models import AbstractUser, Group, Permission
from django.db.models.functions import Rank
from django.db.models.signals import post_migrate
from django.dispatch import receiver
from django.contrib.auth.hashers import make_password
from cloudinary.models import CloudinaryField


class BaseModel(models.Model):
    create_date = models.DateField(auto_now_add=True, null=True)
    update_date = models.DateField(auto_now=True, null=True)
    active = models.BooleanField(default=True)

    class Meta:
        abstract = True


class Role(BaseModel):
    name = models.CharField(max_length=255)  # admin, universityadministrator, lecturer, student

    def __str__(self):
        return self.name


class User(AbstractUser):
    Role_choice = [
        ('admin', 'Quản Trị Viên'),
        ('universityadministrator', 'Giáo Vụ'),
        ('lecturer', 'Giảng Viên'),
        ('student', 'Sinh Viên')
    ]
    avatar = CloudinaryField('image')
    phone = models.CharField(max_length=255, null=True, blank=True)
    role = models.CharField(max_length=50, default='student', null=True, blank=True, choices=Role_choice)

    def has_role(self, required_role):
        return self.role == required_role

    def save(self, *args, **kwargs):
        if self.pk is not None:  # Kiểm tra xem đã có ID (đã tồn tại trong cơ sở dữ liệu) hay chưa
            orig = User.objects.get(pk=self.pk)
            if orig.password != self.password:
                self.password = make_password(self.password)
        else:
            self.password = make_password(self.password)
        # url = self.avatar
        # if 'https://res.cloudinary.com/dyfzuigha/' not in self.avatar:
        #     self.avatar = 'https://res.cloudinary.com/dyfzuigha/' + url
        super().save(*args, **kwargs)

    def __str__(self):
        return self.first_name + ' ' + self.last_name


# Trạng thái khóa luận
class StatusThesis(BaseModel):
    name = models.CharField(max_length=255, null=True)

    def __str__(self):
        return self.name


# Khóa luận
# class Thesis(BaseModel):
#     name = models.CharField(max_length=255, null=True)
#     status = models.ForeignKey(StatusThesis, on_delete=models.RESTRICT)
#
#     def __str__(self):
#         return self.name
#
#     def save(self, *args, **kwargs):
#         if self.pk is None:  # Kiểm tra xem đã có ID (đã tồn tại trong cơ sở dữ liệu) hay chưa
#             self.status = StatusThesis.objects.get_or_create(name='Open')
#         super().save(*args, **kwargs)

# Hội đồng được thành lập
class ThesisDefenseCommittee(BaseModel):
    name = models.CharField(max_length=255, null=True)

    def __str__(self):
        return self.name


class Thesis(BaseModel):
    name = models.CharField(max_length=255, null=True)
    status = models.ForeignKey(StatusThesis, on_delete=models.RESTRICT)
    committee = models.ForeignKey(ThesisDefenseCommittee, on_delete=models.RESTRICT, null=True)

    def __str__(self):
        return self.name

    def save(self, *args, **kwargs):
        if not self.pk:  # Kiểm tra xem đã có ID (đã tồn tại trong cơ sở dữ liệu) hay chưa
            default_status, created = StatusThesis.objects.get_or_create(name='Open')
            self.status = default_status
        super().save(*args, **kwargs)


# Chức Vụ Trong Hội Đồng
class Position(BaseModel):
    name = models.CharField(max_length=255, null=True)

    def __str__(self):
        return self.name


# Thành viên của hội đồng
class MemberOfThesisDefenseCommittee(BaseModel):
    user = models.ForeignKey(User,
                             on_delete=models.CASCADE)  # trước khi xóa user phải cảnh báo bởi vì sẽ xóa luôn trường này.
    Committee = models.ForeignKey(ThesisDefenseCommittee,
                                  on_delete=models.CASCADE)  # trước kih xóa hội đồng phải cảnh báo vì sẽ xóa luôn trường này
    position = models.ForeignKey(Position,
                                 on_delete=models.RESTRICT)  # cái này bị chặn không xóa được nếu vẫn còn record có khóa ngoại ở đây


# Giảng viên hướng dẫn
class ThesisSupervisor(BaseModel):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    thesis = models.ForeignKey(Thesis, on_delete=models.CASCADE)


# Bảng lưu cụ thể sinh viên nào làm khóa luận
class ThesisStudent(BaseModel):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    thesis = models.ForeignKey(Thesis, on_delete=models.CASCADE)


# Hội đồng nào chấm khóa luận nào
class ThesisExaminationCommittee(BaseModel):
    pass
    # thesis = models.ForeignKey(Thesis, on_delete=models.CASCADE)
    # Committee = models.ForeignKey(ThesisDefenseCommittee, on_delete=models.CASCADE)


# Tiêu chí chấm điểm
class Criteria(BaseModel):
    name = models.CharField(max_length=255, null=True)
    percent = models.IntegerField(null=False)

    def __str__(self):
        return self.name


# Điểm số
class Score(BaseModel):
    score = models.FloatField(null=True)
    lecturer = models.ForeignKey(MemberOfThesisDefenseCommittee, on_delete=models.CASCADE, null=True)  # nguoi cham diem
    student = models.ForeignKey(ThesisStudent, on_delete=models.CASCADE, null=True)  # diem cua sinh vien nao
    thesis = models.ForeignKey(Thesis, on_delete=models.CASCADE, null=True)
    criteria = models.ForeignKey(Criteria, on_delete=models.CASCADE, null=True)


@receiver(post_migrate)
def create_superuser(sender, **kwargs):
    if sender.name == 'ThesisManagement':
        admin_username = 'admin'
        admin_password = '123456'

        admin_role, created = Role.objects.get_or_create(name='admin')

        Role.objects.get_or_create(name='universityadministrator')

        Role.objects.get_or_create(name='lecturer')

        Role.objects.get_or_create(name='student')

        Position.objects.get_or_create(name='Chủ Tịch')

        Position.objects.get_or_create(name='Thư Ký')

        Position.objects.get_or_create(name='Phản Biện')

        Position.objects.get_or_create(name='Thành Viên')

        StatusThesis.objects.get_or_create(name='Open')

        StatusThesis.objects.get_or_create(name='Close')

        admin_username = 'admin'
        admin_password = '123456'

        if not User.objects.filter(username=admin_username).exists():
            User.objects.get_or_create(username=admin_username, email='hieu24313@gmail.com', password=admin_password,
                                       role='admin', is_superuser=True, is_staff=True)

        if not User.objects.filter(username='hieu').exists():
            User.objects.get_or_create(username='hieu', email='hieu24314@gmail.com', password=admin_password,
                                       role='admin', is_superuser=True, is_staff=True)

        if not User.objects.filter(username='nhu').exists():
            User.objects.get_or_create(username='nhu', email='huynhnhu@gmail.com', password=admin_password,
                                       role='admin', is_superuser=True, is_staff=True)

        # if not User.objects.filter(username=admin_username).exists():
        #     User.objects.create_superuser(username=admin_username, email='hieu24313@gmail.com', password=admin_password,
        #                                   role='admin')
        #
        # if not User.objects.filter(username='hieu').exists():
        #     User.objects.create_superuser('hieu', 'hieu24314@gmail.com', admin_password, role='admin')
        #
        # if not User.objects.filter(username='nhu').exists():
        #     User.objects.create_superuser('nhu', 'huynhnhu@gmail.com', admin_password, role='admin')
