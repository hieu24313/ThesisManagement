from django.db.models import Q

from .models import User, Criteria


def load_user(params={}):
    q = User.objects.filter(is_active=True)

    username = params.get('username')
    if username:
        q = q.filter(username__icontains=username)

    user_id = params.get('id')
    if user_id:
        q = q.filter(id=user_id)

    name = params.get('name')
    if name:
        q = q.filter(Q(first_name__icontains=name) | Q(last_name__icontains=name))

    return q


def load_criteria(params={}):
    q = Criteria.objects.filter(active=True)

    name = params.get('name')
    if name:
        q = q.filter(name__icontains=name)

    return q