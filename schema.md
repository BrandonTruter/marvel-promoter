## DB schema

### API Mapping

#### characters

id:int
name:string
description:string
modified:Date
resourceURI:string
urls:Array
thumbnail:Image
comics:ResourceList
stories:ResourceList
events:ResourceList
series:ResourceList

series

id:int
title:string
description:string
resourceURI:string
urls:Array
startYear:int
endYear:int
rating:string
modified:Date
thumbnail:Image
comics:ResourceList
stories:ResourceList
events:ResourceList
characters:ResourceList
creators:ResourceList
next:SeriesSummary
previous:SeriesSummary

stories

id:int
title:string
description:string
resourceURI:string
type:string
modified:Date
thumbnail:Image
comics:ComicList
series:SeriesList
events:EventList
characters:CharacterList
