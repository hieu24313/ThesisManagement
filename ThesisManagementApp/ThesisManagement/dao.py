from .models import User, Criteria


def load_user(params={}):
    q = User.objects.filter(active=True)

    username = params.get('username')
    if username:
        q = q.filter(username__icontains=username)

    user_id = params.get('id')
    if user_id:
        q = q.filter(id=user_id)

    return q


def load_criteria(params={}):
    q = Criteria.objects.filter(active=True)

    name = params.get('name')
    if name:
        q = q.filter(name__icontains=name)

    return q