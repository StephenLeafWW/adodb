import times, json

proc newJDateTime*(dt: DateTime): JsonNode =
   return %* {
         "year": dt.year, 
         "month": ord(dt.month),
         "day": ord(dt.monthday),
         "hour": ord(dt.hour),
         "minutes": ord(dt.minute),
         "seconds": ord(dt.second)
      }

proc getDateTime*(n: JsonNode): DateTime =
   ## Retrieves the DateTime value of a `JObject JsonNode`.
   if n.isNil or n.kind != JObject:
      return

   var res: DateTime
   res.monthdayZero = MonthdayRange(getOrDefault(n, "day").getInt(1))
   res.year = getOrDefault(n, "year").getInt(0)
   res.monthZero = getOrDefault(n, "month").getInt(1)
   res.hour = HourRange(getOrDefault(n, "hour").getInt(0))
   res.minute = MinuteRange(getOrDefault(n, "minutes").getInt(0))
   res.second = SecondRange(getOrDefault(n, "seconds").getInt(0))

   return res


   # return DateTime(
   #    monthday: MonthdayRange(getOrDefault(n, "day").getInt(1)),
   #    year: getOrDefault(n, "year").getInt(0),
   #    month: Month(getOrDefault(n, "month").getInt(1)),
   #    hour: HourRange(getOrDefault(n, "hour").getInt(0)),
   #    minute: MinuteRange(getOrDefault(n, "minutes").getInt(0)),
   #    second: SecondRange(getOrDefault(n, "seconds").getInt(0))
   # )
