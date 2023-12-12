from django.test import TestCase
from django.core import mail
# Create your tests here.

def TestSendEmail():
    try:
        conection = mail.get_connection()
        email1 = mail.EmailMessage(
            'Test Send Email',
            'Body Email',
            'hieu01659505026@gmail.com',
            ['2051050138hieu@ou.edu.vn'],
            connection=conection
        )
        email1.send()
        return True
    except ValueError:
        return False


if __name__ == '__main__':
    TestSendEmail()
