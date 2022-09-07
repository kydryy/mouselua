EnablePrimaryMouseButtonEvents(true)
--分解函数
function FenJie()
    MoveMouseTo(6000,17000)
    Sleep(100)
    PressAndReleaseMouseButton(1)
    Sleep(50)
    k=0
    while k<60
    do
        X=k%10-- 分解列
        Y=math.floor(k/10)--分解行
        MoveMouseTo(49000+1700*X,36000+3000*Y)
        Sleep(2)
        PressAndReleaseMouseButton(1)
        Sleep(2)
        PressAndReleaseKey("Enter")
        Sleep(2)
        PressAndReleaseMouseButton(1)
        Sleep(2)
        PressAndReleaseKey("Enter")
        Sleep(2)
        k=k+1
    end
end

Xunhuan_Jiange = 10

function OnEvent(event, arg, family)
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 5 and not IsModifierPressed("lctrl")) then --启动宏，罗技鼠标5为侧键前进
        Quanzidong_Xuanfeng()
    end
    if(event=="MOUSE_BUTTON_PRESSED"and arg==3 and IsModifierPressed("lctrl"))then--CTRL+G3键分解
        FenJie()
    end
    if(event=="MOUSE_BUTTON_PRESSED"and arg==2 and IsModifierPressed("lctrl"))then--CTRL+右键赌博
        k=50
        while k>0
        do
            PressAndReleaseMouseButton(3)
            Sleep(5)
            k=k-1
        end
    end
    if(event=="MOUSE_BUTTON_PRESSED"and arg==1 and IsModifierPressed("lctrl"))then--CTRL+左键拾取
        k=25
        while k>0
        do
            PressAndReleaseMouseButton(1)
            Sleep(15)
            k=k-1
        end
    end
end
--启动函数，把罗技鼠标5和大小写键绑定在一起就可以触发宏
function Quanzidong_Xuanfeng()
    if (IsKeyLockOn("capslock")) then
        --按下并释放1-4键,如需某按键手动，去掉对应按键数并在下面对应自动释放按键程序前加--，既取消该按键自动施放
        PressAndReleaseKey("1", "2", "4")
        --Shift键（右）+鼠标左键，如冲层需要左键手动，可在下面四句前加--，取消自动施放左键功能
        PressKey("rshift")
        Sleep(10)
        ReleaseKey("rshift")

        --按住鼠标右键（启动右键旋风）
        PressMouseButton(3)
        Alt_Pressed = false

        Times_Key_1 = 0
        Times_Key_2 = 0
        Times_Key_4 = 0
        Times_Button_LeftMouse = 0
    end
    --如果CapsLock键已按下则启动循环，否则退出循环
    while (IsKeyLockOn("capslock")) 
    do
        Sleep(Xunhuan_Jiange) --循环间隔
        Times_Key_1 = Times_Key_1 + 1
        Times_Key_2 = Times_Key_2 + 1
        Times_Key_4 = Times_Key_4 + 1
        Times_Button_LeftMouse = Times_Button_LeftMouse + 1
        --每3.5秒按下并释放1键 加速  
        if ((Times_Key_1*Xunhuan_Jiange) == 3500) then
              PressAndReleaseKey("1")
              Times_Key_1 = 0
        end
        --每120秒按下并释放2键  
        if ((Times_Key_2*Xunhuan_Jiange) == 120000) then
            PressAndReleaseKey("2")
            Times_Key_2 = 0
        end
        --每20秒按下并释放4按键
        if ((Times_Key_4*Xunhuan_Jiange) == 20000) then
            PressAndReleaseKey("4")
            Times_Key_4 = 0
        end
        --按住lalt键暂停持续右键，松开恢复
        if (IsModifierPressed("lalt")) then
            if not (Alt_Pressed) then
                ReleaseMouseButton(3)
                Alt_Pressed = true
            end
        else
            if (Alt_Pressed) then
                PressMouseButton(3)
                Alt_Pressed = false
            elseif not (IsMouseButtonPressed(3)) then
                ReleaseMouseButton(3)
                PressMouseButton(3)
            end
        end
    end
    ReleaseMouseButton(3)
end
