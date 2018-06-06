require "rubyserial"

module Zoney
  class Zone
    ZONE_DECODER_REGEX = %r{
      #>
      (\d{2})
      (\d{2})
      (\d{2})
      (\d{2})
      (\d{2})
      (\d{2})
      (\d{2})
      (\d{2})
      (\d{2})
      (\d{2})
      (\d{2})
    }x

    def initialize(port: "/dev/ttyUSB0", number_of_amplifiers: 1)
      @port = port
      @number_of_amplifiers = number_of_amplifiers
    end

    def all
      @zones ||= begin
        data_string = []

        number_of_amplifiers.times do |amplifier_number|
          amp_number = amplifier_number + 1
          carriage_returns = "\r" * amp_number
          data_string << "?#{amp_number}0#{carriage_returns}\n"
        end

        write_data(string: data_string.join) && sleep(1)

        decoded_response
      end
    end

    def find(zone_number:)
      data_string = "?#{zone_number}\r\n"
      write_data(string: data_string) && sleep(1)

      decoded_response[0]
    end

    def power_on(zone_number:)
      update_attribute(zone_number: zone_number, attribute: "pr", value: "01")
    end

    def power_off(zone_number:)
      update_attribute(zone_number: zone_number, attribute: "pr", value: "00")
    end

    def mute(zone_number:)
      update_attribute(zone_number: zone_number, attribute: "mt", value: "01")
    end

    def unmute(zone_number:)
      update_attribute(zone_number: zone_number, attribute: "mt", value: "00")
    end

    def change_source(zone_number:, source_number:)
      update_attribute(
        zone_number: zone_number,
        attribute: "ch",
        value: source_number,
      )
    end

    def change_volume_level(zone_number:, level:)
      update_attribute(
        zone_number: zone_number,
        attribute: "vo",
        value: level,
      )
    end

    def change_bass_level(zone_number:, level:)
      update_attribute(
        zone_number: zone_number,
        attribute: "bs",
        value: level,
      )
    end

    def change_treble_level(zone_number:, level:)
      update_attribute(
        zone_number: zone_number,
        attribute: "tr",
        value: level,
      )
    end

    def update_attribute(zone_number:, attribute:, value:)
      serial_port.write("<#{zone_number}#{attribute}#{value}\r")
    end

    private

    attr_reader :port, :number_of_amplifiers

    def serial_port
      @_serial_port ||= Serial.new(port)
    end

    def read_data
      serial_port.read(10_000)
    end

    def write_data(string:)
      serial_port.write(string)
    end

    def decoded_response
      split_data = read_data.split("\n")
      zone_map =
        split_data.map { |datum| datum.match(ZONE_DECODER_REGEX) }.compact

      zone_map.map do |zone|
        {
          balance: zone[9],
          bass_level: zone[8],
          dt: zone[5],
          keypad: zone[11],
          mute: zone[4],
          pa: zone[2],
          power: zone[3],
          source: zone[10],
          treble_level: zone[7],
          volume_level: zone[6],
          zone_number: zone[1],
        }
      end
    end
  end
end
