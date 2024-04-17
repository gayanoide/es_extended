function StartPayCheck()
	CreateThread(function()
	  while true do
		Wait(Config.PaycheckInterval)
  
		for player, xPlayer in pairs(ESX.Players) do
		  local job = xPlayer.job.grade_name
		  local salary = xPlayer.job.grade_salary
		  local job2 = xPlayer.job2.grade_name
		  local salary2 = xPlayer.job2.grade_salary
  
		  xPlayer.addAccountMoney('bank', 20, "Salaire")
		  --TriggerClientEvent('esx:showAdvancedNotification', player, _U('bank'), _U('received_paycheck'), _U('received_help', 20),'CHAR_BANK_FLEECA', 9)
  
		  if salary >= 1 then
			if job == 'unemployed' then -- unemployed
			  xPlayer.addAccountMoney('bank', salary, "Welfare Check")
			  --TriggerClientEvent('esx:showAdvancedNotification', player, _U('bank'), _U('received_paycheck'), _U('received_help', xPlayer.getJob().label, salary),'CHAR_BANK_FLEECA', 9)
			elseif Config.EnableSocietyPayouts then -- possibly a society
			  TriggerEvent('esx_society:getSociety', xPlayer.job.name, function(society)
				if society ~= nil then -- verified society
				  TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
					if account.money >= salary then -- does the society money to pay its employees?
					  xPlayer.addAccountMoney('bank', salary, "Paycheck")
					  account.removeMoney(salary)
					  --TriggerClientEvent('esx:showAdvancedNotification', player, _U('bank'), _U('received_paycheck'), _U('received_salary' ..xPlayer.getJob().label, salary), 'CHAR_BANK_FLEECA', 9)
					  TriggerClientEvent('esx:showAdvancedNotification', player, _U('bank'), _U('received_paycheck'), _U('received_salary', salary), 'CHAR_BANK_FLEECA', 9)
					else
					  TriggerClientEvent('esx:showAdvancedNotification', player, _U('bank'), '', _U('company_nomoney'), 'CHAR_BANK_FLEECA', 1)
					end
				  end)
				else -- not a society
				  xPlayer.addAccountMoney('bank', salary, "Paycheck")
				  --TriggerClientEvent('esx:showAdvancedNotification', player, _U('bank'), _U('received_paycheck'), _U('received_salary', xPlayer.getJob().label, salary), 'CHAR_BANK_FLEECA', 9)
				end
			  end)
			else -- generic job
			  xPlayer.addAccountMoney('bank', salary, "Paycheck")
			  --TriggerClientEvent('esx:showAdvancedNotification', player, _U('bank'), _U('received_paycheck'), _U('received_salary', xPlayer.getJob().label, salary), 'CHAR_BANK_FLEECA', 9)
			end
		  end
		  if salary2 >= 1 then
			if job2 == 'unemployed' then -- unemployed
			  xPlayer.addAccountMoney('bank', salary2, "Welfare Check")
			  --TriggerClientEvent('esx:showAdvancedNotification', player, _U('bank'), _U('received_paycheck'), _U('received_help', salary2),'CHAR_BANK_FLEECA', 9)
			elseif Config.EnableSocietyPayouts then -- possibly a society
			  TriggerEvent('esx_society:getSociety', xPlayer.job2.name, function(society)
				if society ~= nil then -- verified society
				  TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
					if account.money >= salary2 then -- does the society money to pay its employees?
					  xPlayer.addAccountMoney('bank', salary2, "Paycheck")
					  account.removeMoney(salary2)
					  --TriggerClientEvent('esx:showAdvancedNotification', player, _U('bank'), _U('received_paycheck'), _U('received_salary' ..xPlayer.getJob2().label, salary2), 'CHAR_BANK_FLEECA', 9)
					  TriggerClientEvent('esx:showAdvancedNotification', player, _U('bank'), _U('received_paycheck'), _U('received_salary', salary2), 'CHAR_BANK_FLEECA', 9)
					else
					  TriggerClientEvent('esx:showAdvancedNotification', player, _U('bank'), '', _U('company_nomoney'), 'CHAR_BANK_FLEECA', 1)
					end
				  end)
				else -- not a society
				  xPlayer.addAccountMoney('bank', salary2, "Paycheck")
				  --TriggerClientEvent('esx:showAdvancedNotification', player, _U('bank'), _U('received_paycheck'), _U('received_salary', xPlayer.getJob2().label, salary2), 'CHAR_BANK_FLEECA', 9)
				end
			  end)
			else -- generic job
			  xPlayer.addAccountMoney('bank', salary2, "Paycheck")
			  --TriggerClientEvent('esx:showAdvancedNotification', player, _U('bank'), _U('received_paycheck'), _U('received_salary', xPlayer.getJob2().label, salary2), 'CHAR_BANK_FLEECA', 9)
			end
		  end
		end
	  end
	end)
  end
  