-- https://github.com/dsalt/devilspie2
-- https://www.justingedge.com/linux/devilspie2-automatic-window-placement/
-- https://www.linux-magazine.com/Issues/2017/205/Tutorial-Devilspie2
-- https://askubuntu.com/questions/48321/how-do-i-start-applications-automatically-on-login

-- debug_print("Application: " .. get_application_name())
-- debug_print("Window: " .. get_window_name());


-- if (get_window_name() == "Mozilla Firefox") then
--   set_window_geometry(300, 100, 800, 600);
-- end


if (get_application_name() == "Terminal") then
    maximize();
    -- undecorate_window();
end
