#import "template.typ": *
#import "util.typ": *
#import "state.typ": bib_state
#context bib_state.get()

#h1("Lời cảm ơn", numbering: false)

...

Tôi xin chân thành cảm ơn! \

// #[
//   #set align(right)
//   Tp. Hồ Chí Minh, ngày 05 tháng 06 năm 2025 \
//   Sinh viên thực hiện #h(75pt) \ \ \
//   Ngô Quang Sang #h(80pt)
// ]

#h1("Lời cam đoan", numbering: false)

..

Nếu sai, tôi xin chịu mọi hình thức kỷ luật theo quy định của Học viện. \ \

// #[
//   #set align(right)
//   Tp. Hồ Chí Minh, ngày 05 tháng 06 năm 2025 \
//   Sinh viên thực hiện #h(75pt) \ \ \
//   Ngô Quang Sang #h(80pt)
// ]

#h1("Mục lục", numbering: false)
#outline(
  title: none,
  depth: 3,
  indent: 0em,
)

#h1("Danh mục các ký hiệu, chữ viết tắt", numbering: false)

#tabl(
  columns: (auto, 1fr),
  [*Từ viết tắt*],
  [*Định nghĩa*],
  // [TMĐT],
  // [Thương mại điện tử],
  // [SSL],
  // [Secure Socket Layer],
  // [CSS],
  // [Cascading Style Sheets],
  // [HTML],
  // [HyperText Markup Language - Ngôn ngữ Đánh dấu Siêu văn bản],
  // [RWD],
  // [Responsive web design - Thiết kế responsive],
  // [URL],
  // [Uniform Resource Locator],
  // [PCI DSS],
  // [Payment Card Industry Data Security Standard],
  // [API],
  // [Application Programming Interface],
  // [DBMS],
  // [Database Management System - Hệ quản trị cơ sở dữ liệu],
  // [COD],
  // [Cash on delivery - Thanh toán khi nhận hàng],
  // [SQL],
  // [Structured Query Language],
  // [CSDL],
  // [Cơ sở dữ liệu],
  // [AES],
  // [Advanced Encryption Standard],
  // [JWT],
  // [JSON Web Token],
)

#h1("Danh mục bảng", numbering: false)
#par(
  first-line-indent: 0pt,
  outline(
    title: none,
    target: figure.where(kind: table),
  ),
)

#h1("Danh mục hình vẽ, đồ thị", numbering: false)

#par(
  first-line-indent: 0pt,
  outline(
    title: none,
    target: figure.where(kind: image),
  ),
)

#h1("Mở đầu", numbering: false)
