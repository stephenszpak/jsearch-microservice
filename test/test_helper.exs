ExUnit.start()
Mox.defmock(JobHunt.HttpMock, for: Tesla.Adapter)
Application.put_env(:tesla, :adapter, JobHunt.HttpMock)
