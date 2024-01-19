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


class Majors(BaseModel):
    name = models.CharField(max_length=255, null=True)

    def __str__(self):
        return self.name


class User(AbstractUser):
    Role_choice = [
        ('admin', 'Quản Trị Viên'),
        ('universityadministrator', 'Giáo Vụ'),
        ('lecturer', 'Giảng Viên'),
        ('student', 'Sinh Viên')
    ]

    Gender_choice = [
        ('male', 'Nam'),
        ('female', 'Nữ'),
        ('other', 'Khác'),
        ('secret', 'Bí Mật')
    ]
    avatar = CloudinaryField('image', null=True)
    phone = models.CharField(max_length=255, null=True, blank=True)
    role = models.CharField(max_length=255, default='student', null=True, blank=True, choices=Role_choice)
    major = models.ForeignKey(Majors, null=True, blank=True, on_delete=models.CASCADE)
    date_of_birth = models.DateField(null=True, blank=True)
    gender = models.CharField(max_length=255, null=True, choices=Gender_choice)
    address = models.CharField(max_length=255, null=True)
    temp_password = models.CharField(max_length=255, null=True, blank=True)

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
        return self.last_name + ' ' + self.first_name


class Room(models.Model):
    name = models.CharField(max_length=255, null=False, blank=False, unique=True)
    host = models.ForeignKey(User, on_delete=models.CASCADE, related_name="rooms")
    current_users = models.ManyToManyField(User, related_name="current_rooms", blank=True)

    def __str__(self):
        return f"Room({self.name} {self.host})"


class Message(models.Model):
    room = models.ForeignKey(Room, on_delete=models.CASCADE, related_name="messages")
    text = models.TextField(max_length=500)
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="messages")
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Message({self.user} {self.room})"


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
    major = models.ForeignKey(Majors, null=True, blank=True, on_delete=models.CASCADE)

    def __str__(self):
        return self.name

    def __repr__(self):
        return f"Thesis(id={self.id}, name={self.name}, status_id={self.status_id}, committee_id={self.committee_id}, major_id={self.major_id})"

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
    type = models.CharField(max_length=255, null=True) # gv1 , gv2


# Bảng lưu cụ thể sinh viên nào làm khóa luận
class ThesisStudent(BaseModel):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    thesis = models.ForeignKey(Thesis, on_delete=models.CASCADE)
    total = models.FloatField(null=True)


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
    score = models.FloatField()
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

        Position.objects.get_or_create(name='Thành Viên 1')

        Position.objects.get_or_create(name='Thành Viên 2')

        StatusThesis.objects.get_or_create(name='Open')

        StatusThesis.objects.get_or_create(name='Close')

        Majors.objects.get_or_create(name='Công Nghệ Thông Tin')

        Majors.objects.get_or_create(name='Khoa Học Máy Tính')

        Majors.objects.get_or_create(name='Tài Chính Ngân Hàng')

        Majors.objects.get_or_create(name='Trí Tuệ Nhân Tạo')

        Criteria.objects.get_or_create(name='Điểm Trình Bày', percent=20)

        Criteria.objects.get_or_create(name='Điểm Phản Biện', percent=30)

        Criteria.objects.get_or_create(name='Điểm Sản Phẩm', percent=50)

        admin_username = 'admin'
        admin_password = '123456'

        if not User.objects.filter(username=admin_username).exists():
            User.objects.get_or_create(username=admin_username, email='hieu24313@gmail.com', password=admin_password,
                                       role='admin', is_superuser=True, is_staff=True)

        if not User.objects.filter(username='hieu').exists():
            User.objects.get_or_create(username='hieu', email='2051050138hieu@ou.edu.vn', password=admin_password,
                                       role='admin', is_superuser=True, is_staff=True)

        if not User.objects.filter(username='nhu').exists():
            User.objects.get_or_create(username='nhu', email='2051050327nhu@ou.edu.vn', password=admin_password,
                                       role='admin', is_superuser=True, is_staff=True)

        for i in range(1, 15):
            username = 'sinhvien' + str(i)
            password = '123'
            if not User.objects.filter(username=username).exists():
                User.objects.get_or_create(username=username, password=password,role='student'
                                           , email='hieu24313@gmail.com')

        for i in range(1, 15):
            username = 'giaovu' + str(i)
            password = '123'
            if not User.objects.filter(username=username).exists():
                User.objects.get_or_create(username=username, password=password, role='universityadministrator'
                                           , email='hieu24313@gmail.com')

        for i in range(1, 15):
            username = 'giangvien' + str(i)
            password = '123'
            if not User.objects.filter(username=username).exists():
                User.objects.get_or_create(username=username, password=password, role='lecturer'
                                           , email='hieu24313@gmail.com')

        first_names = ["Hồng", "Trung", "Linh", "Quang", "Thiên", "Phương", "Minh", "Anh", "Dương", "Tâm", "Thu",
                       "Tùng", "Hải", "Ngọc", "Hà", "Tú", "Kiều", "Đức", "Thúy", "Vân"]
        last_names = ["Nguyễn", "Trần", "Lê", "Phạm", "Võ", "Hoàng", "Đặng", "Bùi", "Đỗ", "Lý", "Ngô", "Đinh", "Hồ",
                      "Vũ", "Đào", "Mai", "Quách", "Trịnh", "Đoàn", "Phan"]
        # import random
        # for i in range(47, 48):
        #
        #
        #     # Chọn một tên và họ ngẫu nhiên
        #     random_first_name = random.choice(first_names)
        #     random_last_name = random.choice(last_names)
        #     u = User.objects.get(pk=i)
        #     u.first_name = random.choice(first_names)
        #     u.last_name = random.choice(last_names)
        #     u.save()