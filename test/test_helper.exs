ExUnit.start()

#Mox.defmock(Nostrum.ApiMock, for: Nostrum.Api)

#Application.put_env(:app, :nostrum, Nostrum.ApiMock)
