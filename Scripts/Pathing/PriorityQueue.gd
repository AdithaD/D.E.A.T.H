#extends Node
#
#var items = []
#
#func init():
#	items = []
#
#func insert(item, prio):
#	items.append({"prio": prio, "item": item})
#
#func pop():
#	if len(items) == 0:
#		return null
#	items.sort_custom()
