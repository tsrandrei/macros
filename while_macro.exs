defmodule Loop do
	defmacro while(expression, do: block) do
		quote do
			try do
				for _ <- Stream.cycle([:ok]) do
					if unquote(expression) do
						unquote(block)
					else
						throw :break
					end
				end
			catch
				:break -> :ok
			end
		end
	end
end
# Interactive Elixir (1.10.3) - press Ctrl+C to exit (type h() ENTER for help)
# iex(1)> c "while_macro.exs"
# [Loop]
# iex(2)> import Loop
# Loop
# iex(3)> run_loop = fn ->                                  
# ...(3)> pid = spawn(fn -> :timer.sleep(4000) end)         
# ...(3)> while Process.alive?(pid) do                      
# ...(3)> IO.puts("#{inspect :erlang.time} Stayin' alive!") 
# ...(3)> :timer.sleep 1000                                 
# ...(3)> end                                              
# ...(3)> end
# #Function<45.97283095/0 in :erl_eval.expr/5>
# iex(4)> run_loop.()
# {17, 58, 25} Stayin' alive!
# {17, 58, 26} Stayin' alive!
# {17, 58, 27} Stayin' alive!
# {17, 58, 28} Stayin' alive!
# :ok
