# ErnSlowMagickaRegen
OpenMW mod for slow and subtle magicka regeneration.

When resting, you replenish 0.15 × Intelligence points of Magicka per in-game hour. Two minutes of real time is equivalent to one hour of in-game time.
So the resting regen rate is 0.075 x Intelligence of Magicka per 1 real-time minute.
Or, 0.00125 x Intelligence per 1 real-time second.
If you have 50 Intelligence, that's 1 Magicka every 16 seconds.

But if you're running around and have low Fatigue, you're not really resting. So, multiply that rate by your ratio of current Fatigue.
If you have 25% of your maximum Fatigue, that 1 Magicka per 16 seconds drops to 1 Magicka per 64 seconds.

![example](title_image.jpg)

## Installing
Extract [main](https://github.com/erinpentecost/ErnSlowMagickaRegen/archive/refs/heads/main.zip) to your `mods/` folder.


In your `openmw.cfg` file, and add these lines in the correct spots:

```yaml
data="/wherevermymodsare/mods/ErnSlowMagickaRegen-main"

content=ErnSlowMagickaRegen.omwscripts
```

## Contributing

Feel free to submit a PR to the [repo](https://github.com/erinpentecost/ErnSlowMagickaRegen) provided:

* You assert that all code submitted is your own work.
* You relinquish ownership of the code upon merge to `main`.
* You acknowledge your code will be governed by the project license.


## References

* https://en.uesp.net/wiki/Morrowind:Magicka
* https://en.uesp.net/wiki/Morrowind:Time
