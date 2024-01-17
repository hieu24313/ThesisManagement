from django.core import mail


def send_email(subject='Hồi Đồng Của Bạn Vừa Được Phân Công Chấm Khóa Luận.', body='Hồi Đồng Của Bạn Vừa Được Phân Công'
                                                                                   ' Chấm Khóa Luận.', listreceiver = []):
    try:
        connection = mail.get_connection()
        email1 = mail.EmailMessage(
            subject,
            body,
            'Hội đồng quản lý khóa luận <hieu01659505026@gmail.com>',
            listreceiver,
            connection=connection
        )
        email1.content_subtype = 'html'
        email1.send()
        return True
    except ValueError:
        return False

#
# def send_email():
#     try:
#         conection = mail.get_connection()
#         email1 = mail.EmailMessage(
#             'Test Send Email',
#             'Body Email',
#             'hieu01659505026@gmail.com',
#             ['2051050138hieu@ou.edu.vn'],
#             connection=conection
#         )
#         email1.send()
#         return True
#     except ValueError:
#         return False
