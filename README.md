# Cấu hình Neovim

Cấu hình này dùng `lazy.nvim` để quản lý plugin và Mason để cài Language Server (LSP). Lần mở Neovim đầu tiên cần có mạng để tải plugin và các công cụ Mason.

## Phụ thuộc hệ thống

Tối thiểu cần Neovim (khuyến nghị 0.11+), Git và một shell POSIX. `init.lua` tự tải `lazy.nvim` bằng Git nếu chưa có.

Trên Debian/Ubuntu:

```sh
sudo apt update
sudo apt install git neovim curl unzip build-essential
```

`build-essential` cần cho một số parser của Treesitter. Nếu dùng bản Neovim cũ từ kho hệ điều hành, hãy cài bản Neovim mới hơn từ nguồn phát hành chính thức.

## Cài LSP bằng Mason

Mở Neovim rồi chạy:

```vim
:Mason
```

Mason sẽ tự cài các LSP được khai báo trong `lua/plugins/lsp.lua`. Có thể cài lại hoặc cài thủ công bằng:

```vim
:MasonInstall jdtls clangd lua-language-server typescript-language-server ruff python-lsp-server html-lsp css-lsp dockerfile-language-server terraform-ls json-lsp yaml-language-server
```

Kiểm tra client đang gắn với buffer hiện tại bằng `:LspInfo`.

## Java: JDTLS và thư viện import

Cần JDK **21** (JDK, không phải chỉ JRE). Maven/Gradle cần có khi project sử dụng chúng.

Trên Debian/Ubuntu:

```sh
sudo apt install openjdk-21-jdk maven
# Chỉ cần Gradle toàn hệ thống nếu project không có ./gradlew
sudo apt install gradle
```

Kiểm tra:

```sh
java -version
javac -version
mvn -version
```

Sau đó cài JDTLS trong Neovim:

```vim
:MasonInstall jdtls
```

Đóng và mở lại file `.java` sau khi cài xong. Cấu hình tự nhận diện project qua `.git`, `pom.xml`, `mvnw`, `build.gradle` hoặc `gradlew`; JDTLS sẽ import dependency Maven/Gradle từ project đó. Với JAR không quản lý bằng Maven/Gradle, đặt chúng dưới thư mục `lib/` của project (ví dụ `lib/foo.jar`); mẫu `lib/**/*.jar` đã được khai báo trong cấu hình.

Nếu LSP vừa được cập nhật nhưng dependency vẫn chưa nhận, chạy `:LspRestart`, rồi mở `:LspInfo`. Log chi tiết nằm tại `~/.local/state/nvim/lsp.log`.

## Formatter và runtime bổ sung

Một số formatter trong cấu hình chạy từ `PATH`. Cài theo ngôn ngữ bạn dùng:

```sh
# C/C++
# clang-format được Mason tự cài theo cấu hình.

# Shell
sudo apt install shfmt

# JavaScript/TypeScript, HTML, JSON, YAML, Markdown
# Prettier được Mason tự cài theo cấu hình; không cần cài npm global.

# Python
python3 -m pip install --user ruff
```

Prettier được Mason cài tự động khi mở Neovim có mạng. Cấu hình ép Prettier và clang-format dùng 4 spaces, kể cả khi project có `.prettierrc` hoặc `.clang-format` khác; C/C++ dùng các quy tắc còn lại của LLVM style. Java được JDTLS format-on-save bằng profile Eclipse dùng 4 spaces. Nếu không cài một formatter, thao tác lưu file cho loại file đó có thể báo lỗi định dạng, nhưng LSP vẫn hoạt động.

## Khởi động và cập nhật plugin

```sh
nvim
```

Trong Neovim, dùng `:Lazy` để xem/cập nhật plugin và `:Mason` để xem trạng thái công cụ. Sau khi thay đổi cấu hình LSP, khởi động lại Neovim là cách đơn giản nhất để áp dụng đầy đủ.

## Đọc và sửa file nhị phân

Cấu hình có `hex.nvim` để xem và sửa file nhị phân ở dạng hex. Cài chương trình `xxd` và bảo đảm nó có trong `PATH`:

```sh
# Debian/Ubuntu
sudo apt install xxd
```

Mở file như bình thường, rồi ở Normal mode nhấn `Space b b` để chuyển đổi giữa dạng thường và hex. Bạn cũng có thể dùng `:HexDump`, `:HexAssemble` hoặc `:HexToggle`. Có thể sửa byte trong hex view và lưu bằng `:w`; plugin sẽ chuyển dữ liệu trở lại dạng nhị phân trước khi ghi file.

## Phím tắt (Keymaps)

**Leader Key:** `<Space>`

### 1. Quản lý Cửa sổ, File & Buffer

| Phím tắt                    | Chức năng                                |
| :-------------------------- | :--------------------------------------- |
| `<C-s>` hoặc `<leader>w`    | Lưu file                                 |
| `<leader>sn`                | Lưu file nhưng bỏ qua tự động định dạng  |
| `<C-q>`                     | Đóng file hiện tại                       |
| `<leader>x`                 | Đóng buffer hiện tại (`:bd`)             |
| `<leader>aq`                | Đóng cửa sổ hiện tại có xác nhận         |
| `<leader>Q`                 | Thoát hoàn toàn Neovim có xác nhận       |
| `<leader>n`                 | Mở file/buffer mới trống                 |
| `<leader>v`                 | Chia đôi cửa sổ theo chiều dọc           |
| `<leader>h`                 | Chia đôi cửa sổ theo chiều ngang         |
| `<leader>se`                | Cân bằng kích thước các cửa sổ đang chia |
| `<leader>xs`                | Đóng cửa sổ chia hiện tại                |
| `<C-h/j/k/l>`               | Di chuyển con trỏ giữa các cửa sổ        |
| `<Tab>` / `<S-Tab>`         | Chuyển sang buffer tiếp theo / trước đó  |
| `<leader>to` / `<leader>tx` | Mở / đóng tab mới                        |
| `<leader>tn` / `<leader>tp` | Chuyển sang tab kế tiếp / trước đó       |
| `<leader>e`                 | Bật/tắt thanh duyệt file (Neo-tree)      |
| `<leader>ss` / `<leader>sl` | Lưu / tải lại phiên làm việc (Session)   |

### 2. Chỉnh sửa & Di chuyển con trỏ

| Phím tắt                   | Chức năng                                           |
| :------------------------- | :-------------------------------------------------- |
| `jk` hoặc `kj`             | Thoát Insert mode (nhấn nhanh)                      |
| `<Esc>`                    | Xóa highlight tìm kiếm                              |
| `x`                        | Xóa ký tự nhưng không lưu vào clipboard             |
| `<C-d>` / `<C-u>`          | Cuộn lên/xuống nửa trang và căn giữa                |
| `n` / `N`                  | Tới kết quả tìm kiếm tiếp theo/trước đó và căn giữa |
| `<Up/Down/Left/Right>`     | Thay đổi kích thước cửa sổ                          |
| `<leader>+` / `<leader>-`  | Tăng/giảm giá trị số dưới con trỏ                   |
| `yy`                       | Copy dòng hiện tại vào clipboard hệ thống (`"+yy`)  |
| `<leader>j` (Normal)       | Tìm và thay thế từ đang nằm dưới con trỏ            |
| `<` / `>` (Visual)         | Thụt lề và giữ nguyên vùng chọn                     |
| `<A-j>` / `<A-k>` (Visual) | Di chuyển dòng/đoạn code bôi đen lên/xuống          |
| `p` (Visual)               | Dán đè mà không thay thế bộ nhớ tạm (`"_dP`)        |
| `zR` / `zM`                | Mở / Đóng tất cả các block code (Code folding)      |

### 3. Công cụ mã nguồn & LSP (Ngôn ngữ)

| Phím tắt                    | Chức năng                                                       |
| :-------------------------- | :-------------------------------------------------------------- |
| `gd` / `gD`                 | Đi đến Định nghĩa (Definition) / Khai báo (Declaration)         |
| `gr` / `gI`                 | Xem nơi sử dụng (References) / Phần triển khai (Implementation) |
| `<leader>D`                 | Xem định nghĩa kiểu dữ liệu (Type Definition)                   |
| `<leader>ds` / `<leader>ws` | Tìm symbol trong file hiện tại / toàn bộ workspace              |
| `<leader>rn`                | Đổi tên biến/hàm (Rename)                                       |
| `<leader>ca`                | Gợi ý sửa lỗi code (Code Action)                                |
| `<leader>th`                | Bật/tắt Inlay Hints                                             |
| `<leader>do`                | Bật/tắt cảnh báo (Diagnostics) toàn cục                         |
| `[d` / `]d`                 | Tới lỗi/cảnh báo trước đó / kế tiếp                             |
| `<leader>d` / `<leader>q`   | Hiển thị lỗi popup / Mở danh sách lỗi                           |

### 4. Tìm kiếm với Telescope

| Phím tắt                       | Chức năng                                             |
| :----------------------------- | :---------------------------------------------------- |
| `<leader>ff` hoặc `<leader>sf` | Tìm kiếm file (`find_files`)                          |
| `<leader>fg` hoặc `<leader>sg` | Tìm kiếm nội dung trong toàn bộ project (`live_grep`) |
| `<leader>sh`                   | Tìm kiếm Help Tags                                    |
| `<leader>sk`                   | Tìm kiếm phím tắt                                     |
| `<leader>ss`                   | Chọn các module của Telescope                         |
| `<leader>sw`                   | Tìm kiếm từ dưới con trỏ                              |
| `<leader>sd`                   | Tìm kiếm các cảnh báo/lỗi (Diagnostics)               |
| `<leader>sr`                   | Mở lại phiên tìm kiếm trước đó (Resume)               |
| `<leader>s.`                   | Tìm file dùng gần đây                                 |
| `<leader><leader>`             | Tìm buffer đang mở                                    |
| `<leader>/`                    | Tìm kiếm chữ trong file hiện tại (Fuzzy find)         |
| `<leader>s/`                   | Tìm kiếm chữ trong tất cả các file đang mở            |

### 5. Giao diện & Tiện ích khác

| Phím tắt                   | Chức năng                                   |
| :------------------------- | :------------------------------------------ |
| `<leader>lw`               | Bật/tắt tự động xuống dòng (Line wrap)      |
| `<leader>tt`               | Bật/tắt Terminal (ToggleTerm)               |
| `<leader>r`                | Chạy code (Run Code)                        |
| `<leader>bg`               | Bật/tắt nền trong suốt (Transparency)       |
| `<leader>bb`               | Bật/tắt chế độ xem file nhị phân (Hex view) |
| `<leader>k` / `<leader>tk` | Bật/tắt hiển thị phím gõ trên màn hình      |
