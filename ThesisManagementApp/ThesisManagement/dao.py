from django.db.models import Q

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
