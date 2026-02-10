
ps.boxTarget('thychloride',vector3(-679.77, 5800.7, 17.33), {
	length = 1.0,
	width = 1.0,
	height = 1.0,
	rotation = 340.0,
}, {
	{
		icon = "fas fa-biohazard",
		label = Lang:t("target.process_thionyl_chloride"),
		action = function()
			if not ps.progressbar('Processing Thionyl Chloride', 5000, 'uncuff') then return end
			TriggerServerEvent('ps-drugprocessing:processThionylChloride')
		end,
	},
})
ps.boxTarget('lsdprocess', vector3(2503.53, -427.48, 92.99), {
	length = 1.0,
	width = 1.0,
	height = 1.0,
	rotation = 340.0,
}, {
	{
		icon = "fas fa-biohazard",
		label = Lang:t("target.process_lsd"),
		action = function()
			if not ps.progressbar('Processing LSD', 5000, 'uncuff') then return end
			TriggerServerEvent('ps-drugprocessing:Processlsd')
		end,
	},
})