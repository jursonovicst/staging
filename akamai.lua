pdnslog("pdns-recursor Lua script starting!", pdns.loglevels.Info)

streaming = newDS()
streaming:add("main.ak.t-online.de")

-- return false to say you did not take over the question, but we'll still listen to 'variable'
-- to selectively disable the cache
function preresolve(dq)

    local ednssubnet=dq:getEDNSSubnet()
	if(ednssubnet) then
        pdnslog("Query from "..dq.remoteaddr:toString().."("..ednssubnet:toString().."/"..ednssubnet:getNetwork():toString().."): "..dq.qname:toString(), pdns.loglevels.Info)
    else    
        pdnslog("Query from "..dq.remoteaddr:toString()..": "..dq.qname:toString(), pdns.loglevels.Info)
    end

    if streaming:check(dq.qname) then
    dq:addAnswer(pdns.CNAME, dq.qname:toString().."edgesuite-staging.net.")
        pdnslog("Ingesting CNAME "..dq.qname:toString().."edgesuite-staging.net.", pdns.loglevels.Info)

        dq.rcode = 0
        dq.followupFunction="followCNAMERecords"    -- this makes PowerDNS lookup your CNAME
        return true;
    end

	return false;
end
