from django.db.models import Q, Count
from collections import Counter
from .models import *


def load_user(params={}):
    q = User.objects.filter()

    username = params.get('username')
    if username:
        q = q.filter(username__icontains=username)

    role = params.get('role')
    if role:
        q = q.filter(role=role)

    user_id = params.get('id')
    if user_id:
        q = q.filter(id=user_id)

    name = params.get('name')
    if name:
        q = q.filter(Q(first_name__icontains=name) | Q(last_name__icontains=name))

    active = params.get('active')
    if active:
        q = q.filter(active=active)

    return q


def load_criteria(params={}):
    q = Criteria.objects.filter()

    name = params.get('name')
    if name:
        q = q.filter(name__icontains=name)
    criteria_id = params.get('id')
    if criteria_id:
        q = q.filter(pk=criteria_id)

    active = params.get('active')
    if active:
        q = q.filter(active=active)

    return q


def load_committee(params={}):
    q = ThesisDefenseCommittee.objects.filter()

    name = params.get('name')
    if name:
        q = q.filter(name__icontains=name)

    active = params.get('active')
    if active:
        q = q.filter(active=active)

    return q


def load_thesis(params={}):
    q = Thesis.objects.filter()

    thesis_id = params.get('id')
    if thesis_id:
        q = q.filter(pk=thesis_id)
    name = params.get('name')
    if name:
        q = q.filter(name__icontains=name)

    active = params.get('active')
    if active:
        q = q.filter(active=active)

    return q


def load_member_of_committee(params={}):
    q = MemberOfThesisDefenseCommittee.objects.filter()

    user_id = params.get('user_id')
    if user_id:
        q = q.filter(user=user_id)

    committee = params.get('committee')
    if committee:
        q = q.filter(Committee=committee)

    return q


def load_score(params={}):
    q = Score.objects.filter()

    thesis_id = params.get('thesis')
    if thesis_id:
        q = q.filter(thesis=thesis_id)

    student_id = params.get('student')
    if student_id:
        q = q.filter(student=student_id)

    from_score = params.get('from_score')
    if from_score:
        q = q.filter(score__gte=from_score)

    to_score = params.get('to_score')
    if to_score:
        q = q.filter(score__lte=to_score)
    lecturer_id = params.get('lecturer')
    if lecturer_id:
        # print(lecturer_id)
        q = q.filter(lecturer_id=lecturer_id)

    return q


def load_major(params={}):
    q = Majors.objects.filter()

    name = params.get('name')
    if name:
        q = q.filter(name__icontains=name)

    return q


def get_year_do_thesis():
    list_date_time = Thesis.objects.filter().values('create_date')
    list_year = []
    for i in list_date_time:
        list_year.append(i.get('create_date').year)
    unique_years = sorted(list(set(list_year)))
    # print(unique_years)
    return unique_years


def get_thesis_by_year(year=None):
    q = Thesis.objects.filter()

    if year:
        q = q.filter(create_date__year=year)

    return q


def get_status_by_id(status_id):
    return StatusThesis.objects.get(pk=status_id)


def get_student_by_thesis_id(thesis):
    list_student_id = ThesisStudent.objects.filter(thesis=thesis)
    list_student = []
    for s in list_student_id:
        list_student.append(User.objects.get(pk=s.user_id))
    return list_student


def get_lecturer_by_thesis_id(thesis):
    return ThesisSupervisor.objects.filter(thesis=thesis)


def count_thesis_by_major_and_year(year=None):
    major = Majors.objects.all()

    if year:
        for m in major:
            m.count = Thesis.objects.filter(major=m, create_date__year=year).count()
    else:
        for m in major:
            m.count = Thesis.objects.filter(major=m).count()
    return major


def count_thesis_by_year_all():
    return Majors.objects.annotate(count=Count('thesis__id')).values('id', 'name', 'count')


def get_all_major():
    return Majors.objects.all()


def get_score(year=None, major=None):
    score = ThesisStudent.objects.filter()
    if year:
        score = score.filter(create_date__year=year).values('total')
    else:
        score = score.filter().values('total')

    if major:
        score = score.filter(thesis__major_id=major)
    non_none_values = [result['total'] for result in score if result['total'] is not None]
    counts = Counter(non_none_values)
    print(counts)
    list_diem = []
    for s in non_none_values:
        count = ThesisStudent.objects.filter(total=s).count()
        list_diem.append({'score': s, 'count': count})
    return list_diem

