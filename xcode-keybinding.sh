#!/usr/bin/env bash
##author: zhoujie<zhoujie_903@163.com>
##这个脚本的作用是：自定义xcode的键盘快捷键，Xcode 10有效

# /Applications/Xcode.app/Contents/Frameworks/IDEKit.framework/Resources/IDETextKeyBindingSet.plist
# /Users/zhoujie/Library/Developer/Xcode/UserData/KeyBindings

PLIST="IDETextKeyBindingSet.plist"
KeyBindingSetPlist="/Applications/Xcode.app/Contents/Frameworks/IDEKit.framework/Resources/$PLIST"
DST="~/Desktop"
# echo "从Xcode复制${PLIST}到桌面"
# cp $KeyBindingSetPlist ~/Desktop

# 编辑文件
	# <key>My Custom Actions</key>
	# <dict>
	# 	<key>Insert Line Below</key>
	# 	<string>moveToEndOfLine:, insertNewline:</string>
	# 	<key>Insert Line Above</key>
	# 	<string>moveUp:, moveToEndOfLine:, insertNewline:</string>
	# </dict>

echo "从桌面${PLIST}复制到Xcode"
sudo mv ~/Desktop/$PLIST $KeyBindingSetPlist

open /Applications/Xcode.app/Contents/Frameworks/IDEKit.framework/Resources/


# 参考：
# * [为Xcode添加删除整行、复制整行、在下方新建一行快捷键](https://www.jianshu.com/p/09cfecfb1ab7)
# * [Adding Custom Key-bindings to XCode](http://lonelycoding.com/adding-custom-key-bindings-to-xcode/)