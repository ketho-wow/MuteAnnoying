local _, ns = ...

for _, group in pairs(ns) do
	for fdid in pairs(group) do
		if not unmute[fdid] do 
			MuteSoundFile(fdid)
	end
end
