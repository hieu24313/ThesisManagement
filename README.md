# Backend ThesisManagement

ĐỀ TÀI: QUẢN LÝ KHOÁ LUẬN TỐT NGHIỆP
 Người quản trị được phép quản lý người dùng và đặt vai trò người dùng (giáo vụ, giảng 
viên, sinh viên). Người dùng được phép thay đổi mật khẩu sau khi người quản trị cấp 
tài khoản (tài khoản phải có avatar).
- Giáo vụ khoa được phép ghi nhận khoá luận tốt nghiệp mới vào hệ thống, bao gồm 
thông tin tên khoá luận, các sinh viên thực hiện, các giảng viên hướng dẫn (tối đa 2 
giảng viên).
- Giáo vụ khoa phân công giảng viên phản biện, khi đó giảng viên phản biện sẽ nhận 
thông báo email/sms thông qua hệ thống. 
- Giao vụ khoa thành lập hội đồng bảo vệ khoá luận, một hội đồng tổi thiểu 3, tối đa 5 
giảng viên, trong đó có 1 chủ tịch, 1 thư ký, 1 phản biện và các thành viên (nếu có). 
Một hội đồng có thể chấm điểm cho tối đa 5 khoá luận. Khi chấm điểm các giảng viên 
đăng nhập vào hệ thống và ghi điểm từng tiêu chí cho mỗi khoá luận (các tiêu chí này 
có giao vụ khoa thiết lập sẵn khi giảng viên vào chấm), hệ thống sẽ tự tổng điểm từng 
thành viên và xuất điểm trung bình các thành viên chấm cho một khoá luận. Chú ý tất 
cả thông tin điểm giảng viên chấm cho khoá luận đều phải được hệ thống ghi nhận lại. 
Sau khi hội đồng kết thúc, giáo vụ khoa được phép khoá hội đồng lại, khi đó các giảng 
viên không được phép chỉnh sửa điểm nữa. 
- Người quản trị và giáo vụ được phép xem thống kế điểm khoá luận qua từng năm, tần 
suất tham gia làm khoá luận từng ngành. 
- Sau khi giáo vụ khoá hội đồng sinh viên sẽ nhận email thông báo điểm trung bình chính 
thức từ hội đồng. 
- Hệ thống cho phép xuất bản điểm tổng hợp các điểm trung bình của các thành viên ra 
file pdf phục vụ việc in và trình lãnh đạo ký.
- *Sinh viên nghiên cứu thêm dùng firebase tích hợp chat thời gian thực giữa cửa hàng 
và người dùng
------------------------------------------------------------------------------------
Trong tất cả các đề tài bên dưới đều phải có hệ thống admin quản lý tất các thông tin liên 
quan trong hệ thống. Chương trình yêu cầu thiết kế giao diện nhất quán, các chức năng 
tiện dụng: phát triển backend với Django Rest Framework và frontend với React Native. 
Chứng thực và phân quyền phải thực hiện thông qua OAuth2
Các chức năng (*) là yêu cầu nâng cao, hoàn thành tốt sẽ được xem xét cộng thêm điểm 
lúc vấn đáp. Đăng ký/đăng nhập, các nhóm có thể thử tích hợp bằng tài khoản 
facebook/gmail.
