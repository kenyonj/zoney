RSpec.describe Zoney::Zone do
  describe "#all" do
    context "when 1 amplifier is connected" do
      it "returns an array of 6 zone information hashes" do
        stub_serial_port(read_response: fake_serial_port_response(amplifier_count: 1))
        zoney = Zoney::Zone.new

        result = zoney.all

        expect(result.count).to eq 6
        expect(result).to match_array(expected_result(amplifier_count: 1))
      end
    end

    context "when 2 amplifiers are connected" do
      it "returns an array of 12 zone information hashes" do
        stub_serial_port(read_response: fake_serial_port_response(amplifier_count: 2))
        zoney = Zoney::Zone.new(number_of_amplifiers: 2)

        result = zoney.all

        expect(result.count).to eq 12
        expect(result).to match_array(expected_result(amplifier_count: 2))
      end
    end

    context "when 3 amplifiers are connected" do
      it "returns an array of 18 zone information hashes" do
        stub_serial_port(read_response: fake_serial_port_response(amplifier_count: 3))
        zoney = Zoney::Zone.new(number_of_amplifiers: 3)

        result = zoney.all

        expect(result.count).to eq 18
        expect(result).to match_array(expected_result(amplifier_count: 3))
      end
    end
  end

  describe "#power_on" do
    it "sends the power on string to the amplifier zone" do
      serial_port = stub_serial_port(read_response: "OK")
      zoney = Zoney::Zone.new
      command_string = "<11pr01\r"

      result = zoney.power_on(zone_number: "11")

      expect(serial_port).to have_received(:write).with(command_string).once
    end
  end

  describe "#power_off" do
    it "sends the power on string to the amplifier zone" do
      serial_port = stub_serial_port(read_response: "OK")
      zoney = Zoney::Zone.new
      command_string = "<11pr00\r"

      result = zoney.power_off(zone_number: "11")

      expect(serial_port).to have_received(:write).with(command_string).once
    end
  end

  describe "#mute" do
    it "sends the power on string to the amplifier zone" do
      serial_port = stub_serial_port(read_response: "OK")
      zoney = Zoney::Zone.new
      command_string = "<11mu01\r"

      result = zoney.mute(zone_number: "11")

      expect(serial_port).to have_received(:write).with(command_string).once
    end
  end

  describe "#unmute" do
    it "sends the power on string to the amplifier zone" do
      serial_port = stub_serial_port(read_response: "OK")
      zoney = Zoney::Zone.new
      command_string = "<11mu00\r"

      result = zoney.unmute(zone_number: "11")

      expect(serial_port).to have_received(:write).with(command_string).once
    end
  end

  def stub_serial_port(read_response:)
    double("serial_port", write: 8, read: read_response).tap do |serial_port|
      allow(Serial).to receive(:new).and_return(serial_port)
    end
  end

  def fake_serial_port_response(amplifier_count:)
    amp_info = []
    amplifier_count.times do |count|
      number = count + 1

      amp_info << <<~EOS
        ?#{number}0\r\n
        #>#{number}100000000080707100601\r\r\n
        #>#{number}200000000080707100601\r\r\n
        #>#{number}300000000080707100601\r\r\n
        #>#{number}400000000080707100601\r\r\n
        #>#{number}500000000080707100601\r\r\n
        #>#{number}600000000080707100601\r\r\n
      EOS
    end

    amp_info.join("#")
  end

  def expected_result(amplifier_count:)
    [].tap do |response|
      amplifier_count.times do |amp|
        6.times do |zone_number|
          zone_info = {
            "balance": "10",
            "bass_level": "07",
            "dt": "00",
            "keypad": "01",
            "mute": "00",
            "pa": "00",
            "power": "00",
            "source": "06",
            "treble_level": "07",
            "volume_level": "08",
            "zone_number": "#{amp + 1}#{zone_number + 1}",
          }

          response << zone_info
        end
      end
    end
  end
end
