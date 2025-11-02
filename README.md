# dotfiles - Nix-based macOS Configuration

このリポジトリは、Nixを使用したmacOS開発環境の完全な構成管理を提供します。

## 📋 概要

- **Nix**: パッケージ・構成管理の中心
- **nix-darwin**: macOSシステム設定を宣言的に管理
- **home-manager**: ユーザー環境・dotfilesを管理
- **Bitwarden CLI**: SSH鍵・トークンなどの機密情報を安全に管理
- **Homebrew Cask**: GUIアプリケーションの管理

## 🚀 新しいMacでの初回セットアップ

### 0. 既存のMacでの準備（初回のみ）

既存のMacから新しいMacへ移行する場合、まず既存のMacで秘密情報をBitwardenに保存します：

```bash
# 既存のMacで実行（初回のみ）
cd ~/.dotfiles
export BW_SESSION=$(bw unlock --raw)

# マイグレーションスクリプトを使用（.claude/tmp/migrate_secrets_to_bitwarden.sh）
# または、手動でBitwardenに秘密情報を保存
```

これにより、SSH鍵、API Key、AWS認証情報などがBitwardenの指定フォルダーに保存されます。

### 1. Nixのインストール

Determinate Nix Installerを使用します：

```bash
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
```

インストール後、ターミナルを再起動して確認：

```bash
nix --version
```

### 2. Command Line Tools for Xcodeのインストール

```bash
xcode-select --install
```

### 3. このリポジトリのクローン

**注意**: この段階ではまだSSH鍵が設定されていないため、HTTPSでクローンします。

```bash
# HTTPSでクローン（SSH鍵がまだ設定されていないため）
git clone https://github.com/YuheiNakasaka/dotfiles ~/.dotfiles
cd ~/.dotfiles
```

**後でSSHに切り替える**: SSH鍵の設定後、リモートURLをSSHに変更できます：

```bash
# SSH鍵設定後に実行（任意）
git remote set-url origin git@github.com:YuheiNakasaka/dotfiles.git
```

### 4. Bitwardenでの秘密情報の展開

```bash
# Bitwarden CLIのインストール（Nixがインストール済みの場合）
nix profile add nixpkgs#bitwarden-cli

# Bitwardenにログイン
bw login

# セッションキーを取得してエクスポート
export BW_SESSION=$(bw unlock --raw)

# jqのインストール（この時点ではbrewが使えないため、バイナリを直接ダウンロード）
curl -L https://github.com/jqlang/jq/releases/download/jq-1.8.1/jq-macos-arm64 -o /tmp/jq
sudo mv /tmp/jq /usr/local/bin/jq
sudo chmod +x /usr/local/bin/jq

# jqが使えることを確認
jq --version

# 秘密情報を展開（デフォルトフォルダー: "example"）
./scripts/setup_secrets.sh "your folder name"

# ヘルプを表示
./scripts/setup_secrets.sh --help
```

**重要**: Bitwardenの指定フォルダー内に以下のアイテムを事前に保存しておく必要があります：
- `SSH private key` (Secure Note、notes フィールドに秘密鍵の内容)
- `SSH public key` (Secure Note、notes フィールドに公開鍵の内容)
- `GitHub Token` (Login、password フィールド)
- 各種API Key（必要に応じて、Login、password フィールド）
- `AWS config` (Secure Note、notes フィールド)

### 5. ユーザー設定のカスタマイズ

Nix環境を適用する前に、`flake.nix`のユーザー設定を自分の環境に合わせて編集します：

```bash
# エディタでflake.nixを開く
vim flake.nix  # または code flake.nix, nano flake.nix など
```

以下の`userConfig`セクションを編集してください：

```nix
userConfig = {
  username = "your_username";      # あなたのmacOSユーザー名に変更
  fullName = "Your Full Name";     # あなたの氏名に変更
  email = "your.email@example.com"; # あなたのメールアドレスに変更
};
```

**注意**: `username`は現在ログインしているmacOSのユーザー名と一致させてください。

### 6. Nix環境の適用

```bash
# 初回のみ（nix-darwinをインストールしながら適用）
sudo nix run nix-darwin -- switch --flake .#macbook

# 2回目以降
darwin-rebuild switch --flake .#macbook
```

### 7. 手動セットアップが必要な項目

以下は手動でセットアップしてください：

- **キーボード入力ソース**: システム設定 → キーボード → 入力ソースで以下を追加
  - ABC（英語キーボードレイアウト）
  - 日本語（ローマ字入力）
- **Obsidian vault**: `~/memo`にvaultを配置またはクローン
- **Raycast設定**: Raycastを起動して、`~/.config/raycast/scripts`のスクリプトをImport
  - カスタム設定（Clipboard履歴、Hotkey等）は手動でエクスポート/インポート
- **Keychainアクセス**: 既存Macから手動でエクスポート/インポート
- **開発リポジトリ**: `~/dev`配下の各プロジェクトをクローン

## 🔄 日常的な運用

### 設定を更新する

設定ファイルを編集した後：

```bash
darwin-rebuild switch --flake .#macbook
```

### Flakeの依存関係を更新する

```bash
nix flake update
darwin-rebuild switch --flake .#macbook
```

### 秘密情報を再展開する

Bitwardenのパスワードやキーを更新した場合：

```bash
export BW_SESSION=$(bw unlock --raw)

# デフォルトフォルダー（"example"）から取得
./scripts/setup_secrets.sh

# 特定のフォルダーから取得
./scripts/setup_secrets.sh "your folder name"
```

### 不要なデータを削除する

```bash
nix-collect-garbage -d
darwin-rebuild switch --flake .#macbook
```

### ロールバック

何か問題が起きた場合：

```bash
# 直前の世代に戻す
sudo nix-env --rollback -p /nix/var/nix/profiles/system

# 特定の世代を確認
nix-env --list-generations -p /nix/var/nix/profiles/system
```

## 📁 ディレクトリ構造

```
dotfiles/
├── flake.nix                    # Flakeのエントリーポイント
├── flake.lock                   # 依存関係ロック
├── hosts/
│   └── macbook/
│       ├── darwin.nix          # nix-darwin設定
│       └── home.nix            # home-manager設定
├── modules/
│   ├── system/                 # システムレベルモジュール
│   │   ├── defaults.nix       # macOS環境設定
│   │   └── homebrew.nix       # Homebrew Cask管理
│   └── home/                   # ユーザーレベルモジュール
│       ├── shell.nix          # zsh設定
│       ├── git.nix            # Git設定
│       └── packages.nix       # CLIツール
├── config/                     # dotfiles本体
│   ├── zsh/
│   ├── git/
│   └── raycast/               # Raycastスクリプト
└── scripts/
    └── setup_secrets.sh       # Bitwarden連携
```

## 🔧 カスタマイズ

### ユーザー設定を変更する

`flake.nix`の`userConfig`セクションを編集して、あなたの環境に合わせて設定を変更してください：

```nix
userConfig = {
  username = "your_username";      # macOSのユーザー名
  fullName = "Your Full Name";     # Gitで使用される名前
  email = "your.email@example.com"; # Gitで使用されるメールアドレス
};
```

この設定は以下の場所で自動的に使用されます：
- システムユーザー設定（`/Users/<username>`）
- Home Manager設定
- Git設定（名前とメールアドレス）
- 信頼されたNixユーザー

### 修飾キー（Modifier Keys）のカスタマイズ

キーボードの修飾キー（Caps Lock、Control、Option、Commandなど）のマッピングを変更できます。

現在の設定：**Caps Lock → Command**

変更するには、`modules/system/defaults.nix`の修飾キーマッピングセクションを編集してください：

```nix
# 現在の設定: Caps Lock → Command
defaults -currentHost write -g com.apple.keyboard.modifiermapping.0-0-0 -array \
  '<dict>
    <key>HIDKeyboardModifierMappingSrc</key>
    <integer>30064771129</integer>  # Caps Lock
    <key>HIDKeyboardModifierMappingDst</key>
    <integer>30064771303</integer>  # Command
  </dict>'
```

**よく使われるマッピング例：**

| マッピング | Src (変更元) | Dst (変更先) |
|-----------|-------------|-------------|
| Caps Lock → Control | 30064771129 | 30064771296 |
| Caps Lock → Command | 30064771129 | 30064771303 |
| Caps Lock → Option | 30064771129 | 30064771298 |
| Control → Command | 30064771296 | 30064771299 |

**修飾キーコード一覧：**

| キー | コード |
|------|--------|
| Caps Lock | 30064771129 (0x700000039) |
| Left Control | 30064771296 (0x7000000E0) |
| Left Shift | 30064771297 (0x7000000E1) |
| Left Option | 30064771298 (0x7000000E2) |
| Left Command | 30064771299 (0x7000000E3) |
| Right Control | 30064771300 (0x7000000E4) |
| Right Shift | 30064771301 (0x7000000E5) |
| Right Option | 30064771302 (0x7000000E6) |
| Right Command | 30064771303 (0x7000000E7) |

### 新しいCLIツールを追加する

`modules/home/packages.nix`を編集：

```nix
home.packages = with pkgs; [
  # 既存のパッケージ...
  neovim  # 追加例
];
```

### 新しいGUIアプリを追加する

`modules/system/homebrew.nix`を編集：

```nix
casks = [
  # 既存のcask...
  "visual-studio-code"  # 追加例
];
```

### macOS設定をカスタマイズする

`modules/system/defaults.nix`を編集して、お好みのシステム設定を追加できます。

### プロジェクトごとの開発環境

各プロジェクトディレクトリに`flake.nix`または`shell.nix`を作成：

```nix
# shell.nix の例
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nodejs_20
    ruby_3_3
    postgresql
  ];

  shellHook = ''
    echo "プロジェクト開発環境に入りました"
  '';
}
```

プロジェクトディレクトリで：

```bash
nix-shell  # または nix develop (Flakeの場合)
```

## ⚠️ 重要な注意事項

### 機密情報の管理

- **絶対にコミットしてはいけないファイル**:
  - `~/.secrets`
  - `~/.ssh/id_ed25519`
  - `~/.aws/credentials`
  - `~/.aws/config`
  - `.env`ファイル

- これらは`.gitignore`に追加してください：

```bash
# グローバル.gitignore に追加
git config --global core.excludesFile ~/.gitignore_global

cat >> ~/.gitignore_global << 'EOF'
.secrets
.env
.env.local
EOF
```

### アーキテクチャの確認

`flake.nix`の`system`設定を確認してください：
- Apple Silicon (M1/M2/M3): `aarch64-darwin`
- Intel Mac: `x86_64-darwin`

### Homebrewの管理

このNix設定ではHomebrew Caskを使用していますが、`brew`コマンドは引き続き使用できます。
ただし、Nix管理外のアプリは`darwin-rebuild`時に削除される可能性があります（`cleanup = "zap"`設定のため）。

## 🐛 トラブルシューティング

### Nix daemonが起動しない

```bash
sudo launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist
```

### darwin-rebuild がエラーになる

```bash
# Flakeのキャッシュをクリア
rm -rf ~/.cache/nix

# 再度試す
darwin-rebuild switch --flake .#macbook
```

### Homebrewのアプリがインストールされない

```bash
# 手動でインストール
brew install --cask <app-name>

# または、Homebrewを再同期
brew bundle --file=/dev/stdin <<< "$(darwin-rebuild switch --flake .#macbook 2>&1 | grep 'cask')"
```

### Bitwardenのフォルダーが見つからない

```bash
# 利用可能なフォルダーを確認
export BW_SESSION=$(bw unlock --raw)
bw list folders --session $BW_SESSION | jq -r '.[] | .name'

# フォルダーを作成
bw get template folder | jq '.name = "your folder name"' | \
  bw encode | bw create folder --session $BW_SESSION

# スクリプト実行時に正しいフォルダー名を指定
./scripts/setup_secrets.sh "your folder name"
```

### Bitwardenのアイテムが取得できない

```bash
# 特定のフォルダー内のアイテムを確認
FOLDER_ID=$(bw list folders --session $BW_SESSION | jq -r '.[] | select(.name == "your folder name") | .id')
bw list items --folderid $FOLDER_ID --session $BW_SESSION | jq '.[] | {name: .name, type: .type}'

# アイテムのタイプを確認（1: Login, 2: Secure Note）
# SSH key, AWS credentialsなどはtype=2（Secure Note）である必要があります
```

## 📚 参考資料

- [Nix Manual](https://nixos.org/manual/nix/stable/)
- [nix-darwin](https://github.com/LnL7/nix-darwin)
- [Home Manager](https://github.com/nix-community/home-manager)
- [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer)
- [Bitwarden CLI](https://bitwarden.com/help/cli/)

## 📄 License

MIT
