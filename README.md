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
