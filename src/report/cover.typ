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
      ĐỀ TÀI NGHIÊN CỨU KHOA HỌC \ \
      #text(weight: "bold", size: 16pt, "SO SÁNH TĂNG TỐC TRUY VẤN \n DỰA VÀO GPU VÀ CPU VỚI HEAVYDB VÀ DUCKDB") \ \ \
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
              *Nguyễn Văn A* - CT010101 \
              *Nguyễn Văn B* - CT010102 \
              *Nguyễn Văn C* - CT010103 \
              *Nguyễn Văn D* - CT010104 \
              *Nguyễn Văn E* - CT010105 \
            ],
          )
          _Giảng viên hướng dẫn_: \
          #pad(
            left: 1cm,
            top: 0.5cm,
            [
              *ThS. Nguyễn Văn F* \
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
