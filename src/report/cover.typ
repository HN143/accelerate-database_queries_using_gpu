#let cover(border: true) = {
  rect(
    width: 100%,
    height: 100%,
    stroke: if (border) {
      2.5pt
    } else {
      0pt
    },
    [
      #set align(center)
      \
      BAN CƠ YẾU CHÍNH PHỦ \
      *HỌC VIỆN KỸ THUẬT MẬT MÃ*
      #line(start: (0%, 20pt), length: 3.5cm)
      #image("./images/logo.png", width: 3.5cm) \
      BÁO CÁO TỔNG KẾT \ 
      ĐỀ TÀI NGHIÊN CỨU KHOA HỌC SINH VIÊN
      \ \
      *ĐỀ TÀI* \
      #text(weight: "bold", size: 16pt, "TĂNG TỐC TRUY VẤN CƠ SỞ DỮ LIỆU SỬ DỤNG GPU") \ \ \
      #set align(left)
      #pad(
        left: 8cm,
        [
          #"\t\t\tNgành: Công nghệ thông tin" \
          // #"Mã số: 7.48.02.02" \
        ],
      ) \

      #pad(
        left: 2cm,
        [
          _Sinh viên thực hiện_: \
          #pad(
            left: 1cm,
            top: 0.5cm,
            [
              *Nguyễn Thị Hồng Ngân* - CT060229 \
              *Tô Quang Viễn* - CT060146 \
              *Nguyễn Ngọc Tuyền* - CT060145 \
              *Bùi Đức Khánh* - CT060119 \
              
            ],
          )
          _Giảng viên hướng dẫn_: \
          #pad(
            left: 1cm,
            top: 0.5cm,
            [
              *ThS. Cao Thanh Vinh* \
              Khoa Công Nghệ Thông Tin - Học viện Kỹ thuật Mật Mã
            ],
          )
        ],
      )

      #set align((center + bottom))

      #pad(bottom: .25cm, "Hà Nội, 2025")
    ],
  )
}
